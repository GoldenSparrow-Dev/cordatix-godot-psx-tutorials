# How to Make a Swarm Monster in Godot 4

A swarm monster is hundreds of small creatures that move as one thing: a heap that rises, a column, a shape that breaks apart when you hit it and comes back together. This script is the heart of one: worms in one MultiMesh (one draw call, no bones), each with its own place in the swarm's shape, crawling there at a worm's pace, so a new shape reads as worms crawling, never as a shape morphing. A blow throws the worms nearest it off; they fall, writhe a moment and crawl back to their places. The wriggle is the shader's: a wave down each worm, its phase the worm's own.

**See it working:** the GIF on [the tutorial's page](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/make-a-swarm-monster/).

**Script:** [`swarm_monster.gd`](swarm_monster.gd) · Godot 4.3 or newer

## How to use it

1. Add a `Node3D` and attach `swarm_monster.gd`. The worms live in the world (top_level): the node is only where the swarm's shape is, so move the node and the worms crawl after it.
2. Set `count`, `worm_length` and `crawl_speed`, and `shape` to `heap` (a mound, `radius` across) or `column` (a pillar about head height). Change `shape` at any time: the worms crawl to their new places.
3. Call `hit(amount, at)` with a number of worms and a point in the world (a bullet's hit, a blow): that many of the worms nearest the point are thrown off it.
4. A shape of your own is a new branch in `_slot(i)`: it turns each worm's own numbers (an angle, a radius, a height) into a place in the node's space.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- Nothing else: the worm's mesh and its shader are made in the script.

## Try it free

The [Cordatix PSX Horror Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) carries this script as `cordatix/psx_horror_swarms/sampler/swarm_monster.gd`. J in the sampler's demo room opens its Swarms taste: worms living in a torn mattress and a hole in the floor pour out as you come near, gather into a heap and rise into a column, and the demo's revolver throws them off. The pack's own monsters build on this: a man of worms that bursts and rises again, a great worm that stands up out of a mattress, worms on a ceiling that drop their strands on you; hits, nests, navigation and seven looks.

## Tested

In Godot 4.3 and 4.7.2, in the free sampler's project: one MultiMesh of 160 worms (one draw call), every worm in its heap, the column rising in under a second as the worms crawl, a hit throwing the 30 worms nearest it off, all of them back in their places within seconds, the swarm moved 2 m and its worms crawling after it, and the worm's faces pointing out.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Make a Swarm Monster in Godot 4 (Cordatix PSX Horror Swarms)](https://cordatix.itch.io/cordatix-psx-horror-swarms/devlog/1746555/how-to-make-a-swarm-monster-in-godot-4-cordatix-psx-horror-swarms) on itch.io, written for [Cordatix PSX Horror Swarms](https://cordatix.itch.io/cordatix-psx-horror-swarms), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
