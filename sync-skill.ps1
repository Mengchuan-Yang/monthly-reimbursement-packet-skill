param(
    [string]$RepoPath = "C:\Users\as705\.codex\skills\monthly-reimbursement-packet",
    [string]$Branch = "main",
    [switch]$SkipPull
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $RepoPath)) {
    throw "Repo path not found: $RepoPath"
}

Write-Host "== Skill Repo Sync ==" -ForegroundColor Cyan
Write-Host "Repo:   $RepoPath"
Write-Host "Branch: $Branch"

$gitDir = Join-Path $RepoPath ".git"
if (-not (Test-Path -LiteralPath $gitDir)) {
    throw "Not a git repository: $RepoPath"
}

Write-Host "`n[1/5] Checking remotes..."
git -C $RepoPath remote -v

Write-Host "`n[2/5] Fetching latest refs..."
git -C $RepoPath fetch --prune origin

if (-not $SkipPull) {
    Write-Host "`n[3/5] Pulling latest changes (rebase)..."
    git -C $RepoPath pull --rebase origin $Branch
}
else {
    Write-Host "`n[3/5] Pull skipped by -SkipPull."
}

Write-Host "`n[4/5] Current branch and latest commit..."
git -C $RepoPath branch --show-current
git -C $RepoPath log --oneline -n 1

Write-Host "`n[5/5] Working tree status..."
git -C $RepoPath status --short

Write-Host "`nSync complete." -ForegroundColor Green
