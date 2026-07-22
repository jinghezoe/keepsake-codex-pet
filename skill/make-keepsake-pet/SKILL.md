---
name: make-keepsake-pet
description: Turn approved photos, character references, memories, and identity notes about a friend, family member, self, or deceased loved one into a respectful Codex v2 animated pet. Use when creating, repairing, or publishing a personal-likeness or memorial pet that needs consent checks, identity preservation, coordinated emotional animation, privacy-safe handling, all nine standard states, sixteen look directions, QA, and packaging through the hatch-pet workflow.
---

# Make a Keepsake Codex Pet

## Overview

Create a recognizable pet without treating a person as generic style material. Establish permission and privacy first, extract stable identity anchors, design emotionally truthful motion, delegate sprite production to `$hatch-pet`, and package only approved outputs.

## Required dependency

Load and follow the installed `$hatch-pet` skill before preparing or modifying any pet run. If it is unavailable, stop and explain that this skill requires a current Codex v2 `hatch-pet` workflow; do not improvise atlas assembly or skip its QA.

Read [consent-and-care.md](references/consent-and-care.md) for any real-person likeness. Read [identity-and-motion.md](references/identity-and-motion.md) before writing the generation brief. Read [release-checklist.md](references/release-checklist.md) before publishing or sharing files.

## Workflow

### 1. Establish authority and audience

Determine who the pet represents, who supplied the references, whether the person consented, and whether the result is private, shared, or public. Never assume that possession of a photo authorizes public release. For memorial work, keep the first output private by default and avoid simulated speech or claims that the pet represents the person's views.

If these boundaries are missing but the user only asked for a private local build, proceed with private-by-default handling and do not publish source images. If the user asks to publish a recognizable likeness, require explicit confirmation of permission before the external write.

### 2. Inventory references

Use 3–8 approved images when available: front, three-quarter or side, full body, identity-defining accessories, and characteristic expression. Reject or crop files containing unrelated bystanders, addresses, identity documents, private chats, or other unnecessary personal information. Do not copy raw photos into the final pet package.

### 3. Write the identity brief

Record:

- identity anchors that must remain stable across every row;
- personality cues expressed as visual energy, not invented biography;
- flexible details that may be simplified at `192×208`;
- explicit avoidances, including inaccurate colors, materials, props, or features;
- publication boundary and source-photo handling.

Use observable language. Prefer “two matte-black cloth whiskers attached to the snout with upward C/S curls” over “fun dragon details.” Do not infer race, health, religion, sexuality, or other sensitive traits from appearance.

### 4. Define emotional and physical mechanics

Give every supported state a distinct purpose. Express emotion through posture, face, and attached physical parts, not detached symbols or decorative effects. When a hat, mask, plush, puppet, or accessory reads as a second face, decide whether it joins the person's emotion and gaze. Keep both identities coordinated unless the user's concept specifically requires contrast.

For grief or failure, avoid humiliation or melodrama by default. A curled-up or crying pose is acceptable when requested, readable, and respectful. Preserve the person's dignity and the pet's established construction.

### 5. Produce with `$hatch-pet`

Pass the approved references, identity brief, emotional mechanics, and privacy boundary into `$hatch-pet`. Follow its complete v2 workflow: all nine standard rows, four approved cardinal anchors, two coherent look rows, deterministic 8×11 assembly, despill, validation, blind direction QA, final visual QA, and `spriteVersionNumber: 2` packaging.

Do not ask image generation for a complete atlas. Do not patch newly generated individual look cells into an otherwise coherent row. Do not weaken cardinal-direction or identity gates to finish faster.

### 6. Review at pet size

Inspect the standard and extended contact sheets, each row GIF, and the labeled direction sheet. Confirm that a stranger can distinguish states while someone familiar with the subject can recognize the identity anchors. Specifically compare neutral, failed, waiting, review, and all four cardinal directions side by side.

Ask the represented person or authorized requester to review likeness-sensitive details when practical. Treat discomfort as a repair signal even when technical QA passes.

### 7. Package and release safely

Install only `pet.json` and `spritesheet.webp` under the active Codex home: `$CODEX_HOME/pets/<pet-id>/`, defaulting to `~/.codex/pets/<pet-id>/` on macOS, Linux, and WSL2 or `$HOME\.codex\pets\<pet-id>\` in native Windows PowerShell. Keep raw references and rejected generations outside the package. Before any public release, apply [release-checklist.md](references/release-checklist.md), remove local paths and metadata, and state the artwork license separately from the skill or documentation license.

## Output expectations

Finish with:

- pet name, id, description, and private/public scope;
- concise identity anchors and expressive-mechanics decisions;
- installed package paths or staged package paths;
- atlas geometry and `spriteVersionNumber`;
- QA outcome and preview/contact-sheet paths;
- a clear statement that raw source photos were excluded from any public package.
