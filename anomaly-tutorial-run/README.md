# How to Script a Tutorial Run for an Anomaly Game in Godot 4

![A tutorial of your own game, the devlog's example, on the free sampler's car park in Godot 4 with the PSX look: level 2, a scripted one, its hint in a band at the foot of the view, a shopping trolley in leg A's aisle; the player turns back to the stairs they came by, the move, and level 1's hint](tutorial_run.gif)

An anomaly game teaches its rule on its first levels: one to learn, one with something plainly wrong, one clean again. This script holds those levels as steps, each an anomaly's id ("" for a clean level) and a hint, and hands them to the loop's `queue()` on each run's first level. It works out the step from the number of the level the player is on, so whatever begins a new run (a wrong choice, a catch, your menu's Start) begins the tutorial from the top, and a Continue picks it up on the level it loads. A wrong choice or a catch says what was missed; once the last scripted level is left the right way, the tutorial is done and every level is drawn.

**Script:** [`anomaly_tutorial.gd`](anomaly_tutorial.gd) · Godot 4.3 or newer

## How to use it

1. Add `anomaly_tutorial.gd` to a Node in your level and set `loop` to your loop's node: it needs `queue(ids)`, `start_floor` and the signals `entered_floor(number, anomaly)` and `chosen(correct, anomaly)`, with `caught(anomaly)` if your loop has one.
2. Set `steps` to your scripted levels, `[[anomaly id, hint], ...]` ("" for a clean level), and `first_hint` to the hint on the run's first level, which is always clean.
3. Connect `hint` to a `Label` ("" hides it), and `passed` to your save: keep `done` there, and set it back from the save in your level's `_ready`, before the player is on the run's first level.
4. A restart from your game's own key or menu makes no choice: hide the hint there yourself; the run's first level then brings the first one.

## What it needs

- A loop with `queue()`, `start_floor` and the signals above (the pack's loop has them, and so can yours), and anomalies with an `id` and, for the hint after a miss, a `description`.

## Try it free

The [Liminal PSX Parking Anomalies Free Sampler](https://cordatix.itch.io/liminal-psx-parking-anomalies-free) has the looping car park and the pack's loop game (version 1.1), with five anomalies on a run of three levels: the tutorial runs on its loop as it is, and an anomaly it queues counts in the draw.

## Tested

In Godot 4.3 and 4.7.2, on a stand-in loop and on the free sampler's own loop: the run's first level shows the first hint and queues the steps; they come in order, each hint with its level and gone with its choice; a wrong choice or a catch says what was missed and starts the tutorial over; a new run begun mid-tutorial starts it over, and a Continue picks it up on the level it loads; with `done` set from a save nothing is queued or said; a step that does not fit the run never shows, and the run ends at the way out; on the pack's loop a scripted anomaly counts as shown in the draw.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Script a Tutorial Run for an Anomaly Game in Godot 4 (Liminal PSX Parking Anomalies)](https://cordatix.itch.io/liminal-psx-parking-anomalies/devlog/1733191/how-to-script-a-tutorial-run-for-an-anomaly-game-in-godot-4-liminal-psx-parking-anomalies-11) on itch.io, written for [Liminal PSX Parking Anomalies](https://cordatix.itch.io/liminal-psx-parking-anomalies), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
