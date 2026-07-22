# Complete tutorial: from approved memories to a Codex pet

This tutorial uses Dragon Hood Girl as a worked example, but the workflow applies to friends, family members, self-portraits, and carefully handled memorial projects.

## 1. Decide the boundary before collecting images

Write down:

- who the pet represents;
- whether the person has agreed;
- whether the final files are private, shared with a small group, or public;
- which features must remain recognizable;
- which private details must never appear.

For a living person, obtain explicit permission. For someone who has died, prefer a private result and consult family or rights holders before publishing. The pet should evoke a memory, not impersonate the person.

## 2. Select references

Use 3–8 images when possible:

- one clear front view;
- one three-quarter or side view;
- one full-body image for proportions and clothing;
- close views of identity-defining accessories;
- optional images showing a characteristic expression or gesture.

Avoid screenshots containing private chats, addresses, ID cards, children who are not part of the project, or unrelated bystanders. Remove metadata before sharing or committing files.

## 3. Write an identity brief

Separate observations into three groups.

### Identity anchors

These must not drift between animation rows. For Dragon Hood Girl they were:

- a full, rounded pale-yellow plush dragon hood;
- large white dragon eyes, black pupils and brows;
- orange horns, dark-blue crest, beige nostrils, white teeth, and red lining;
- two matte-black cloth whiskers attached to the snout, with playful upward C/S curls;
- long black hair, brown jacket, cream dress, and white crossbody bag.

### Personality cues

Describe emotional energy rather than biography: gentle, mischievous, shy, focused, theatrical, calm, and so on.

### Flexible styling

List details that may be simplified at `192×208`: tiny jewelry, fabric texture, background objects, or very fine patterns.

## 4. Decide how expressive objects participate

A hat, plush toy, mask, puppet, or accessory can behave like a second character only when that matches the original idea. Define whether it:

- shares the person's emotion;
- reacts with a slight delay;
- looks in the same direction;
- stays inert during serious states;
- has a physically attached moving part such as ears, whiskers, or a strap.

For Dragon Hood Girl, the dragon hood is a second face. Both faces blink, look, wait, work, celebrate, and become sad together. The black cloth whiskers remain attached and follow head motion with a restrained lag.

## 5. Invoke the reusable skill

Install this repository's skill and provide only approved source images:

```text
Use $make-keepsake-pet.
Create a private Codex pet from these approved reference photos.
The non-negotiable identity anchors are: ...
The emotional tone is: ...
Keep the result private and do not copy the source photos into the final package.
```

The skill should then use the current `hatch-pet` workflow. Do not ask an image generator for one complete 8×11 atlas; generate grounded state rows and use deterministic assembly and validation.

## 6. Design all nine standard states

Each row needs a distinct visual story:

- `idle`: breathing, blinking, or a quiet material sway;
- `running-right` / `running-left`: directional drag locomotion with alternating cadence;
- `waving`: a clear greeting without floating motion marks;
- `jumping`: vertical movement through body position only;
- `failed`: a readable response to danger or blockage;
- `waiting`: an expectant request for permission or input;
- `running`: focused task work, not literal running;
- `review`: completion, attention, or satisfaction.

The Dragon Hood Girl failed row deliberately tells an eight-frame story: standing sadness, attached tears, sinking knees, kneeling, curling inward, rolling to the side, and ending in a side-prone fetal curl. The girl and dragon face close their eyes together.

## 7. Design sixteen look directions

Rows 9–10 use this order:

```text
row 9:  000, 022.5, 045, 067.5, 090, 112.5, 135, 157.5
row 10: 180, 202.5, 225, 247.5, 270, 292.5, 315, 337.5
```

`000` means up. `090` is screen-right, `180` is down, and `270` is screen-left. Neutral/front belongs to the pointer dead zone and falls back to idle.

Define what leads and what follows. For a humanoid pet, the eyes normally lead, then eyelids and brows, head and neck, upper body, hair, and attached accessories. Keep feet, scale, and baseline stable. Do not rotate or warp the whole sprite to fake direction.

## 8. Package the pet

The final folder must contain exactly the manifest and the atlas:

```text
$CODEX_HOME/pets/<pet-id>/
├── pet.json
└── spritesheet.webp
```

`CODEX_HOME` defaults to `~/.codex` on macOS, Linux, and WSL2, and to `$HOME\.codex` in native Windows PowerShell. Keep native Windows and WSL2 installations separate; install inside the environment that runs the Codex agent.

Example manifest:

```json
{
  "id": "your-pet-id",
  "displayName": "Your Pet Name",
  "description": "One sentence describing the pet.",
  "spritesheetPath": "spritesheet.webp",
  "spriteVersionNumber": 2
}
```

The v2 atlas must be `1536×2288`, representing `8×11` cells of `192×208`. `spriteVersionNumber: 2` is essential; without it, the app may interpret the asset using the older nine-row contract.

## 9. Validate before installing

Require all of the following:

- correct atlas dimensions and populated cells;
- transparent background with no hidden chroma residue;
- stable identity, scale, baseline, props, and clothing;
- distinct motion in all nine standard rows;
- unmistakable four cardinal directions;
- coherent clockwise interpolation across all sixteen look cells;
- a contact sheet, focused direction sheet, and per-row GIF previews;
- independent visual QA for direction and animation semantics.

Inspect at actual pet size. A face that looks correct when enlarged may be unreadable in the app.

## 10. Publish the process, not private evidence

A public repository can safely include:

- the skill;
- a sanitized identity brief;
- the state and direction design notes;
- `pet.json` examples;
- contact sheets and GIFs that the represented person has approved;
- validation results without local paths or private metadata.

Do not include raw source photos, chat logs, image-generation credentials, hidden answer keys that expose private material, or work folders containing rejected likeness attempts.
