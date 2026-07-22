# Codex pet configuration

## Folder contract

```text
$CODEX_HOME/pets/<pet-id>/
├── pet.json
└── spritesheet.webp
```

`CODEX_HOME` defaults to `~/.codex` on macOS, Linux, and WSL2, and to `$HOME\.codex` in native Windows PowerShell. `<pet-id>` should use lowercase letters, digits, and hyphens. Keep the manifest and spritesheet together.

## `pet.json`

```json
{
  "id": "dragon-hood-girl",
  "displayName": "Dragon Hood Girl",
  "description": "A cheerful chibi girl in a plush pale-yellow dragon hood with expressive twin faces, curled black cloth whiskers, long black hair, a cream dress, and a white crossbody bag.",
  "spritesheetPath": "spritesheet.webp",
  "spriteVersionNumber": 2
}
```

| Field | Meaning |
| --- | --- |
| `id` | Stable folder-safe identifier; match the pet directory name. |
| `displayName` | Name shown in the Codex UI. |
| `description` | One concise sentence for humans. |
| `spritesheetPath` | Relative atlas filename inside the pet folder. |
| `spriteVersionNumber` | Use `2` for an 8×11 atlas with look directions. |

## Atlas geometry

- cell: `192×208` pixels;
- columns: `8`;
- rows: `11`;
- total: `1536×2288` pixels;
- format: transparent PNG or WebP; this example uses WebP.

The first nine rows contain the standard states. Rows 9–10 contain sixteen clockwise look directions. Do not package an 8×9 intermediate atlas as a new v2 pet.

## Installation

### macOS, Linux, or WSL2

```bash
PET_ID="your-pet-id"
mkdir -p "$HOME/.codex/pets/$PET_ID"
cp pet.json "$HOME/.codex/pets/$PET_ID/pet.json"
cp spritesheet.webp "$HOME/.codex/pets/$PET_ID/spritesheet.webp"
```

Use a task-specific variable such as `PET_ID`; do not redefine shell environment variables such as `HOME`.

### Native Windows PowerShell

For the included example, run the verified installer from the repository root:

```powershell
.\scripts\install-windows.ps1 -PetOnly
.\scripts\verify-windows.ps1 -PetOnly
```

For another packaged pet:

```powershell
$petId = "your-pet-id"
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$petDirectory = Join-Path $codexHome "pets\$petId"
New-Item -ItemType Directory -Force -Path $petDirectory | Out-Null
Copy-Item ".\pet.json" (Join-Path $petDirectory "pet.json") -Force
Copy-Item ".\spritesheet.webp" (Join-Path $petDirectory "spritesheet.webp") -Force
```

Use a task-specific variable such as `$petId`; do not overwrite `$HOME` or `$env:CODEX_HOME` inside an install script. Native Windows and WSL2 have separate home directories, so install from the environment that runs the active Codex agent.

## Update and verification

Run the Windows installer again to replace the known package files, then verify the manifest and SHA-256 hashes:

```powershell
.\scripts\install-windows.ps1 -PetOnly
.\scripts\verify-windows.ps1 -PetOnly
```

On macOS, Linux, or WSL2, repeat the copy commands and compare the installed files with the package before restarting Codex.

## Backup and deletion behavior

The installed pet lives under `$CODEX_HOME/pets/<pet-id>`. A source project, Git repository, or Codex task can be deleted without removing that installed copy. Conversely, deleting the pet folder removes the installed custom pet even if a source repository still exists.

Keep at least one recoverable copy of `pet.json` and `spritesheet.webp` outside temporary project folders.

On Windows, preview deletion before acting:

```powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$petDirectory = Join-Path $codexHome "pets\your-pet-id"
Remove-Item -LiteralPath $petDirectory -Recurse -Force -WhatIf
```

Remove `-WhatIf` only after confirming the resolved path names the exact pet directory you intend to delete.
