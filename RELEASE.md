# Release Process

## 1) Update Metadata

1. Update `VERSION`.
2. Add release notes to `CHANGELOG.md`.
3. Update docs (`README.md`, `SKILL.md`) if input/output contracts changed.

## 2) Commit and Tag

```bash
git add .
git commit -m "release: vX.Y.Z"
git tag vX.Y.Z
```

## 3) Push

```bash
git push origin main
git push origin vX.Y.Z
```

## 4) Create GitHub Release

```bash
gh release create vX.Y.Z --title "vX.Y.Z" --notes-file CHANGELOG.md
```

## 5) Post-Release Check

1. Verify repository README displays correctly.
2. Verify tag exists remotely.
3. Verify release notes include key workflow changes.
