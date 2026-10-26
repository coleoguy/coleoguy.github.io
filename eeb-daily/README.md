# EEB Daily

Nightly evolutionary biology newsletter for the Blackmon lab. A cloud ChatGPT Work task researches and writes the next issue using the owner's existing subscription. GitHub Actions validates, builds, and deploys the site. Neither stage needs the owner's computer to be running, and no model API key is used.

- `index.html`: latest issue (stable URL, QR target)
- `issues/YYYY-MM-DD.html`: every issue
- `archive/index.html`: archive index
- `build-your-own.html`: generic guide for other labs
- `manifest.json`: generated archive summary and previously used source identifiers
- `inbox/YYYY-MM-DD.json`: pending issue submitted by the cloud editor; excluded from the published site
- `data/NNNN-YYYY-MM-DD.json`: accepted canonical issue records
- `tools/validate.py`: structural, editorial, duplicate, and safe-markup checks for new records
- `tools/publish.py`: validates the inbox before accepting any new records

## Publishing

The cloud task reads the private editorial configuration through the connected Google Drive account. The configuration and its people-priority list are not copied into this public repository. The task reads `manifest.json` and pending inbox entries before selecting its date and next issue number. It submits only one new inbox record through the GitHub plugin.

The `EEB Daily and lab website` workflow uses standard GitHub-hosted runners and GitHub's own short-lived token. It accepts valid records, regenerates newsletter outputs with `python3 eeb-daily/tools/build.py`, saves them to `master`, builds the entire Jekyll website, and deploys a Pages artifact explicitly. Ordinary pushes to `master` also deploy the whole website. GitHub Pages must use **GitHub Actions** as its publishing source.

An inbox validation failure retains the previous newsletter, while unrelated lab-site updates can still deploy. The workflow reports the rejected newsletter after deployment. Read the workflow's error log, correct the pending JSON, and rerun the workflow. Do not change the validator to make unverified content pass. Identical retries are safe; conflicting records for an existing date or number are rejected. Never fix a rejected push by force-pushing.

## Editorial evidence

New records include `source_audit` entries documenting the actual sources read for the featured paper, each author, and both side stories. These entries support human auditing; passing automated validation does not establish that scientific claims are true. Abstract-only access must be stated in the evidence, and the text must stay within what the abstract supports. Omit unverified biographical details.

Existing historical records are retained as published, including two October 21 issues. New records must satisfy the current validation rules and cannot introduce another duplicate date. See `tools/RECORD.md` for the record format.

## Cost and recovery

The AI task uses ChatGPT subscription capacity, shared with other Work/Codex activity. Do not add model API credentials, purchase credits, or enable paid runners as part of this pipeline. If subscription limits or an app approval block a run, report the block and keep the previous issue online. GitHub's recovery runs can publish an already-submitted issue; they cannot research or write a missing one.
