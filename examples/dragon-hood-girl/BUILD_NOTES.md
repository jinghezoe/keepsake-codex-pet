# Dragon Hood Girl build notes

## Why the earlier animation felt limited

The asset already contained all nine named states, but several triggers are transient or require specific application events. Non-idle reactions play briefly and then visually return to idle. The correct repair was to strengthen the semantic storytelling in each supported row, not to invent unsupported row names.

## Dragon hood as a second face

The hood participates in every animation:

- calm double blink in `idle`;
- determined shared facing during drag locomotion;
- greeting wink in `waving`;
- coordinated surprise in `jumping`;
- shared sadness and closed eyes in `failed`;
- expectant attention in `waiting`;
- synchronized focus in task `running`;
- satisfied attention in `review`;
- matched gaze across all sixteen look directions.

## Failed-row repair

The previous v2.1 failed row was replaced without changing any other state. The repaired row uses an eight-frame progression:

1. standing shared sadness;
2. attached tears begin;
3. knees start to sink;
4. kneeling;
5. seated curl;
6. side roll;
7. low side-prone curl;
8. final fetal curl with both faces' eyes closed.

The whiskers remain black, attached, and upward-curled. The crossbody bag and strap remain attached on the same side.

## QA outcome

- atlas: `1536×2288`, 8×11, 192×208 cells;
- manifest: `spriteVersionNumber: 2`;
- deterministic validation: passed with zero errors and warnings;
- three isolated blind direction reviews: unanimous across all tested axis pairs;
- independent final visual QA: passed.
