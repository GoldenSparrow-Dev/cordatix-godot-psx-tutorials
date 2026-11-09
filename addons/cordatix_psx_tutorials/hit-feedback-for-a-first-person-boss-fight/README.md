# How to Add Hit Feedback and Sounds to a Boss Fight in Godot 4

In a first-person fight the player cannot see their own blow land on a boss across the room, so the game has to say it. One CanvasLayer listens to three signals: a weapon's `struck` when a blow or a shot lands, its `clip_event` as its animation passes a moment, and the player's `hurt`. It plays a sound for each through four voices, so a shot and its hit do not cut each other off, marks a hit with four short ticks round the crosshair and the player's hurt with red edges; both fade.

**See it working:** the GIF on [the tutorial's page](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/hit-feedback-for-a-first-person-boss-fight/).

**Script:** [`hit_feedback.gd`](hit_feedback.gd) · Godot 4.3 or newer

## How to use it

1. Add a `CanvasLayer` to your scene and attach `hit_feedback.gd`.
2. Give it `sounds`, a dictionary by name: `hit`, `hurt`, and one per clip event (`swing`, `shot`). A name with no sound is skipped.
3. Call `watch_weapon()` for every weapon (any node with `struck(target, amount, at)` and `clip_event(event, clip, data)`) and `watch_player()` for the player (any node with `hurt(amount, source)`).
4. Tune `tick_color`, `tick_fade` and `hurt_fade`; connect `played` to see each sound as it plays.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- Weapons and a player that send the three signals; any sounds of your own.

## Try it free

The Cordatix PSX Horror Free Sampler has the Offcut, PSX Horror Bosses' mini-boss, to fight; the script itself needs no file of a pack: give it your own weapons, player and sounds.

## Tested

In Godot 4.3 and 4.7.2: on stand-ins (a node with a weapon's two signals, one with the player's hurt) a blow sets the ticks and plays the hit, a shot plays its sound and an event with none is skipped, the player's hurt reddens the edges, and both fade; in the pack, on its own first-person player and its nine items too.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Add Hit Feedback and Sounds to a First-Person Boss Fight in Godot 4 (Cordatix PSX Horror Bosses 2.0)](https://cordatix.itch.io/cordatix-psx-horror-bosses/devlog/1766008/how-to-add-hit-feedback-and-sounds-to-a-first-person-boss-fight-in-godot-4-cordatix-psx-horror-bosses) on itch.io, written for [Cordatix PSX Horror Bosses](https://cordatix.itch.io/cordatix-psx-horror-bosses), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
