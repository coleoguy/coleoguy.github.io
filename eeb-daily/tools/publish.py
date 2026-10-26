#!/usr/bin/env python3
"""Validate and accept EEB Daily inbox records without any AI or network calls.

Run from the repository root::

    python3 eeb-daily/tools/publish.py --check
    python3 eeb-daily/tools/publish.py

Inbox names are YYYY-MM-DD.json. The cloud author supplies the next issue number.
Every pending record is checked before canonical records are touched. An exact
replay is consumed; a conflicting replay or any invalid candidate rejects the
whole batch. This command never edits an existing canonical issue, invokes git,
or deploys. The workflow retains the last canonical issue after a rejection and
still deploys unrelated website updates, then reports the newsletter failure.
"""

import argparse
import json
import re
import sys
from datetime import date, datetime, timedelta
from pathlib import Path
from zoneinfo import ZoneInfo

from validate import validate_record


ROOT = Path(__file__).resolve().parents[2]
INBOX_NAME = re.compile(r"\d{4}-\d{2}-\d{2}\.json\Z")
DATA_NAME = re.compile(r"\d{4,}-\d{4}-\d{2}-\d{2}\.json\Z")
MAX_RECORD_BYTES = 100_000


class PublishError(ValueError):
    """A batch cannot be accepted safely."""


def read_record(path):
    if path.is_symlink() or not path.is_file():
        raise PublishError(f"{path.name}: expected a regular file, not a link")
    if path.stat().st_size > MAX_RECORD_BYTES:
        raise PublishError(f"{path.name}: issue exceeds {MAX_RECORD_BYTES} bytes")
    try:
        record = json.loads(path.read_text(encoding="utf-8"))
    except (UnicodeError, json.JSONDecodeError) as exc:
        raise PublishError(f"{path.name}: invalid UTF-8 JSON: {exc}") from exc
    if not isinstance(record, dict):
        raise PublishError(f"{path.name}: expected a JSON object")
    return record


def load_archive(data_dir):
    if data_dir.is_symlink() or not data_dir.is_dir():
        raise PublishError("eeb-daily/data must be an existing regular directory")
    records = []
    for path in sorted(data_dir.glob("*.json")):
        if not DATA_NAME.fullmatch(path.name):
            raise PublishError(f"Unexpected archive filename: {path.name}")
        record = read_record(path)
        if type(record.get("no")) is not int or record["no"] < 1:
            raise PublishError(f"{path.name}: invalid archived issue number")
        if f'{record["no"]:04d}-{record.get("date", "")}.json' != path.name:
            raise PublishError(f"{path.name}: archive filename does not match issue")
        records.append(record)
    numbers = [record["no"] for record in records]
    if len(numbers) != len(set(numbers)):
        raise PublishError("Archive contains duplicate issue numbers")
    # Duplicate dates in the historical archive are intentional; leave them alone.
    return sorted(records, key=lambda record: record["no"])


def plan_batch(root, today=None):
    """Return an immutable-by-convention plan; perform no filesystem writes."""
    root = Path(root).resolve()
    today = today or datetime.now(ZoneInfo("America/Chicago")).date()
    latest_allowed = today + timedelta(days=1)
    data_dir = root / "eeb-daily/data"
    inbox = root / "eeb-daily/inbox"
    archived = load_archive(data_dir)
    if inbox.is_symlink():
        raise PublishError("eeb-daily/inbox must not be a symlink")
    if inbox.exists() and not inbox.is_dir():
        raise PublishError("eeb-daily/inbox must be a directory")
    pending = sorted(inbox.glob("*.json")) if inbox.exists() else []
    planned = []
    existing = list(archived)
    for path in pending:
        if not INBOX_NAME.fullmatch(path.name):
            raise PublishError(f"{path.name}: inbox filename must be YYYY-MM-DD.json")
        record = read_record(path)
        issue_date = path.stem
        if record.get("date") != issue_date:
            raise PublishError(f"{path.name}: filename does not match record date")
        collisions = [item for item in existing
                      if item.get("date") == issue_date or item.get("no") == record.get("no")]
        if collisions:
            if len(collisions) == 1 and collisions[0] == record:
                planned.append((path, None, record))
                continue
            raise PublishError(f"{path.name}: conflicts with a published issue date or number")
        try:
            parsed_date = date.fromisoformat(issue_date)
        except ValueError as exc:
            raise PublishError(f"{path.name}: not a valid calendar date") from exc
        if parsed_date > latest_allowed:
            raise PublishError(f"{path.name}: issue date is later than tomorrow in America/Chicago ({latest_allowed})")
        errors = validate_record(record, existing, expected_date=issue_date)
        if errors:
            raise PublishError(f"{path.name}:\n  " + "\n  ".join(errors))
        destination = data_dir / f'{record["no"]:04d}-{issue_date}.json'
        if destination.exists() or destination.is_symlink():
            raise PublishError(f"{destination.name}: destination already exists")
        planned.append((path, destination, record))
        existing.append(record)
    return planned, existing


def accept_pending(root=ROOT, check=False, today=None):
    plan, records = plan_batch(root, today=today)
    imported = [target.name for _, target, _ in plan if target is not None]
    replayed = [source.name for source, target, _ in plan if target is None]
    if not check:
        # Exclusive creation ensures existing canonical records cannot be replaced.
        # A failed acceptance is local only; the workflow restores the newsletter
        # checkout before rebuilding from the last canonical issue on failure.
        created = []
        try:
            for _, target, record in plan:
                if target is not None:
                    with target.open("x", encoding="utf-8") as output:
                        created.append(target)
                        json.dump(record, output, ensure_ascii=False, indent=2)
                        output.write("\n")
        except Exception:
            for target in created:
                target.unlink(missing_ok=True)
            raise
        for source, _, _ in plan:
            source.unlink()
    latest = max(records, key=lambda record: record["no"]) if records else None
    return {
        "check_only": check,
        "imported": imported,
        "replayed": replayed,
        "consumed": len(plan),
        "latest_no": latest["no"] if latest else None,
        "latest_date": latest["date"] if latest else None,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT, help="repository root")
    parser.add_argument("--check", action="store_true", help="validate without changing files")
    args = parser.parse_args()
    try:
        result = accept_pending(args.root, args.check)
    except (PublishError, OSError) as exc:
        print(f"EEB Daily was not published: {exc}", file=sys.stderr)
        return 1
    print(json.dumps(result))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
