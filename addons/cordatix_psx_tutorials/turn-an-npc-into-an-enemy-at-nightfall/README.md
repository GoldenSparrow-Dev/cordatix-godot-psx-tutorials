# How to Turn an NPC into an Enemy at Nightfall in Godot 4

The scariest enemy is the one the player walked past an hour ago. A villager is two instances of one model: Day, an ordinary person with its day clips, and Night, the enemy; only one shows at a time. When the darkness from your sky passes `turn_at`, the day body plays Turn, a clip made to end on the night body's first Idle frame, and on that last frame the night body takes its place in the same pose. At dawn the day body steps back in; a hidden body is also stopped, so it costs nothing.

**See it working:** the GIF on [the tutorial's page](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/turn-an-npc-into-an-enemy-at-nightfall/).

**Script:** [`night_turn.gd`](night_turn.gd) · Godot 4.3 or newer

**In this addon** the script has no `class_name` line: the tutorial makes it the global class `NightTurn`, and a Cordatix pack or free sampler in your project may declare that class already (Godot takes each class name once). Where the steps below name the class, add `class_name NightTurn` above `extends` in your copy if no pack in the project declares it.

## How to use it

1. Add a `Node3D` and attach `night_turn.gd`. Give it two children, `Day` and `Night`: two instances of one villager's model, each with its own AnimationPlayer.
2. The model's clips: the day's (`Day_Idle` by default), `Turn`, which ends on the night's first Idle frame, and the night's (`Idle`). Rename them in `day_idle`, `turn_clip` and `night_idle`.
3. Set `darkness` from your sky, 0 by day to 1 at night. The villager turns at `turn_at` and comes back at `dawn_at`; in between it stays as it is, so a cloud over the moon does not flip it.
4. Connect `turned` (true at nightfall, false at dawn) and give the night body your enemy script.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- A rigged character with day clips, a Turn clip and night clips on one skeleton.

## Try it free

The free demo on PSX Horror Villagers' page (Download demo) has the ploughman with every clip, day and night, the lean tan dog, both of the pack's scripts and a corner of the village: try the script on the ploughman right away.

## Tested

In Godot 4.3 and 4.7.2, with the ploughman from the free demo: by day the day body shows; in the dark it plays Turn and the night body takes over in the same pose; at dawn the day body is back; the signal fires both ways.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Turn an NPC into an Enemy at Nightfall in Godot 4 (PSX Horror Villagers)](https://cordatix.itch.io/psx-horror-villagers/devlog/1754522/how-to-turn-an-npc-into-an-enemy-at-nightfall-in-godot-4-psx-horror-villagers) on itch.io, written for [PSX Horror Villagers](https://cordatix.itch.io/psx-horror-villagers), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
