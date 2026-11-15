# How to Ring a Bell That Swings in Its Turret in Godot 4

![The village hall's bell turret of Cordatix PSX Horror Village in Godot 4 with the PSX look at dusk: the bronze bell swings on its headstock in the open turret, three strokes in small steps, over the clock stopped at five past six, then it swings down to rest](ring_the_bell.gif)

A bell that rings in a horror game should swing, not just play a sound. One script swings any bell on its headstock in the stepped motion of PS1 games: its swing grows over the first pull, the clapper strikes at the top of every swing (a signal, and your own sound if you give it one), and when its strokes are rung it swings down to rest. It can ring itself when the player walks near.

**Script:** [`ring_the_bell.gd`](ring_the_bell.gd) · Godot 4.3 or newer

## How to use it

1. Put the bell's mesh under a `Node3D` whose X axis is the headstock (turning it about X swings the bell), add a parent `Node3D` and attach `ring_the_bell.gd` to it; set `pivot` to the headstock node.
2. Call `ring(n)` for n strokes, or `ring()` to ring until `stop()`. Connect `struck` for anything that should happen at a stroke, or set `sound` to an `AudioStreamPlayer3D`: it plays at every stroke.
3. Set `swing_deg`, `period` and `steps` (poses a second; 0 for a smooth swing). Give it an `Area3D` as `ring_when_near` and it rings `strokes_when_near` strokes when a body walks in.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- A bell under a node that turns about its X axis; a sound of your own if you want one.

## Try it free

The code works on any bell mesh of yours; the free sampler has no bell (Cordatix PSX Horror Village's hall carries one in its turret).

## Tested

In Godot 4.3 and 4.7.2, with a stand-in bell in any project: ring(3) strikes three times at the tops of its swings, plays the sound each time and comes to rest; the swing stays within its degrees and changes pose in steps; ring() rings until stop() and then strikes no more; a body walking into the area rings it once, not again while it rings. In the pack's own project the hall's bell swings and strikes with it as well.

## The devlog and the pack

The step-by-step walkthrough comes as a devlog on itch.io on 23 November 2026; this README is the tutorial until then. It is written for [Cordatix PSX Horror Village](https://cordatix.itch.io/cordatix-psx-horror-village), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
