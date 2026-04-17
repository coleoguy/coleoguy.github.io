# Deprecated

Archived snapshot of earlier site content. **Nothing in this directory is linked from the current site.** All files are kept only for historical reference / to preserve old URLs.

Most content here has been superseded:

| Old file | Superseded by |
|----------|---------------|
| `index.html` | root `index.html` (Jekyll-templated) |
| `phylo101.html` | `subpages/phylo101.html` + `phylo-methods/` interactive guide |
| `expdes45.html` | `subpages/expdes.html` |
| `TA-assignmentapp.html` | `subpages/TA-assignmentapp.html` |
| `TGS.workshop.html` | (one-off workshop page, no replacement) |
| `assets/`, `images/` | root `assets/` |

## Safe to delete?

Yes, if you don't need the old snapshots:
- `deprecated/` is excluded from Jekyll builds (`_config.yml`), so keeping it doesn't affect the deployed site.
- Total size is ~85 MB — deleting would shrink the working tree noticeably.
- Git history preserves everything; nothing is truly lost.

```sh
git rm -rf deprecated/
git commit -m "Remove deprecated archive (superseded content)"
```

If you'd rather keep it as a visible archive, consider moving it to a `archive` branch and tagging before removing from `master`.
