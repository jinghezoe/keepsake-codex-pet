# Windows installation and compatibility

The repository supports the native Windows ChatGPT desktop app and WSL2. The packaged pet is platform-neutral: `pet.json` uses a relative `spritesheetPath`, and the artwork is a WebP atlas.

## 1. Choose native Windows or WSL2

The [official Windows app](https://learn.chatgpt.com/docs/windows/windows-app) uses the Windows-native Codex agent and PowerShell by default. It can also run the agent in WSL2.

- **Native Windows agent:** follow the PowerShell instructions below. Files are installed under `CODEX_HOME`, normally `$HOME\.codex`.
- **WSL2 agent:** follow the macOS/Linux Bash commands in the main README. Files are installed inside the Linux home at `~/.codex`.

These are separate environments. Installing a pet into the Windows user profile does not automatically install it into the WSL2 home, or vice versa. Install into the environment that actually runs the Codex agent.

If the Windows app is not installed yet, use the Microsoft Store or run:

```powershell
winget install --id 9PLM9XGG6VKS -s msstore
```

## 2. Install from the repository

Open PowerShell in the repository root. Install both Dragon Hood Girl and the reusable skill:

```powershell
.\scripts\install-windows.ps1
.\scripts\verify-windows.ps1
```

Install only one component when needed:

```powershell
.\scripts\install-windows.ps1 -PetOnly
.\scripts\install-windows.ps1 -SkillOnly
```

The scripts use an existing `CODEX_HOME` value when present. Otherwise they use `$HOME\.codex`. You may select an explicit location without changing your environment:

```powershell
.\scripts\install-windows.ps1 -CodexHome "D:\CodexHome"
.\scripts\verify-windows.ps1 -CodexHome "D:\CodexHome"
```

The installer creates missing target folders, copies the package, checks `pet.json`, and verifies SHA-256 hashes. Restart or reload the desktop app after installation.

## 3. Manual pet installation

If you prefer not to run the installer script:

```powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$petDirectory = Join-Path $codexHome "pets\dragon-hood-girl"
New-Item -ItemType Directory -Force -Path $petDirectory | Out-Null
Copy-Item ".\examples\dragon-hood-girl\package\pet.json" $petDirectory -Force
Copy-Item ".\examples\dragon-hood-girl\package\spritesheet.webp" $petDirectory -Force
```

The resulting folder must contain exactly the installable manifest and atlas:

```text
$CODEX_HOME\pets\dragon-hood-girl\
├── pet.json
└── spritesheet.webp
```

## 4. Update

Pull or download the new repository version, then run the installer and verifier again. The two known package files are replaced and hash-checked.

```powershell
git pull --ff-only
.\scripts\install-windows.ps1
.\scripts\verify-windows.ps1
```

## 5. Safe removal

Preview the exact targets first:

```powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$petDirectory = Join-Path $codexHome "pets\dragon-hood-girl"
$skillDirectory = Join-Path $codexHome "skills\make-keepsake-pet"
Remove-Item -LiteralPath $petDirectory -Recurse -Force -WhatIf
Remove-Item -LiteralPath $skillDirectory -Recurse -Force -WhatIf
```

After checking the printed paths, remove `-WhatIf` only for the component you intend to delete. Removing the cloned repository does not remove an installed copy, and removing the installed copy does not delete the repository.

## 6. Troubleshooting

- **The script is blocked:** inspect it first, then run `Unblock-File .\scripts\install-windows.ps1, .\scripts\verify-windows.ps1` and retry. Do not lower the machine-wide execution policy.
- **The pet is not listed:** run `verify-windows.ps1`, restart or reload the desktop app, and confirm you installed into the Codex home used by the active Windows or WSL2 agent.
- **A custom Codex home is used:** pass the same path through `-CodexHome`, or set `CODEX_HOME` before starting Codex and the installer.
- **Only the skill or pet is wanted:** use the matching `-SkillOnly` or `-PetOnly` switch for both installation and verification.

The repository's `Windows compatibility` GitHub Actions workflow runs these installation and verification paths on `windows-latest` for every pull request and every push to `main`.
