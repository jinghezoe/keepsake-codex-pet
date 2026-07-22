# Codex pet configuration

## Folder contract

```text
~/.codex/pets/<pet-id>/
├── pet.json
└── spritesheet.webp
```

`<pet-id>` should use lowercase letters, digits, and hyphens. Keep the manifest and spritesheet together.

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

```bash
PET_ID="your-pet-id"
mkdir -p "$HOME/.codex/pets/$PET_ID"
cp pet.json "$HOME/.codex/pets/$PET_ID/pet.json"
cp spritesheet.webp "$HOME/.codex/pets/$PET_ID/spritesheet.webp"
```

Use a task-specific variable such as `PET_ID`; do not redefine shell environment variables such as `HOME`.

## Backup and deletion behavior

The installed pet lives under `~/.codex/pets/<pet-id>`. A source project, Git repository, or Codex task can be deleted without removing that installed copy. Conversely, deleting the pet folder removes the installed custom pet even if a source repository still exists.

Keep at least one recoverable copy of `pet.json` and `spritesheet.webp` outside temporary project folders.
