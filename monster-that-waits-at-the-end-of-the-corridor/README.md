# How to Make a Monster That Waits at the End of the Corridor in Godot 4

![In a lit cream office corridor, the Watcher of Liminal PSX Entities, a giant folded under the ceiling, waits at the far end. You walk up to it and it stays where it is, backing off as you come; you turn your back and walk away, and when you turn round it has followed you, still at the same distance](corridor_watcher.gif)

Most monsters run at you. This one waits at the end of the corridor: walk toward it and it backs away, still facing you; turn your back and it follows, and when you look again it is still there, at its distance. One script on any CharacterBody3D with a NavigationAgent3D: it asks whether the camera sees it, then backs away, follows or stands and watches.

**Script:** [`corridor_watcher.gd`](corridor_watcher.gd) · Godot 4.3 or newer

## How to use it

1. Put `corridor_watcher.gd` on your monster's `CharacterBody3D`, with a `NavigationAgent3D` child named "NavigationAgent3D" and a collision shape.
2. Put your player in the group "player", its `Camera3D` the current camera.
3. Set `near`, the distance it keeps while you watch it, and `far`: farther than that it comes for you whether you look or not.
4. If the model has an `AnimationPlayer` with Idle, Walk and Retreat (a walk played backwards), they play.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- A navigation mesh for it to follow along (straight at you where there is none), and a player in the group "player" with the current camera.

## Try it free

Liminal PSX Entities' free demo, on its page, has Nape on the Overtime floor; the Watcher is in the pack. The code works on any CharacterBody3D of yours.

## Tested

In Godot 4.3 and 4.7.2 on a stand-in body in a straight corridor: a collider on your own body (a held torch) does not hide it; seen and approached, it backs away and keeps its distance; it never comes closer while watched; unseen, it follows.

## The devlog and the pack

The step-by-step walkthrough comes as a devlog on itch.io on 7 December 2026; this README is the tutorial until then. It is written for [Liminal PSX Entities](https://cordatix.itch.io/liminal-psx-entities), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
