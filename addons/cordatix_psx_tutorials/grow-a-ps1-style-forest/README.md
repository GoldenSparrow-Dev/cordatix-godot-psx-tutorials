# How to Grow a PS1-Style Forest in Godot 4

A forest in a PS1-style game is a trick: a few kinds of tree, scattered by a seed, the near ones as models, the far ones as flat cards, and the fog's end as the edge of the world. This script, on a Node3D, is that trick: trees scattered over an area by a seed (one seed, one forest), kept off the trails you draw as Path3D curves, set on the ground below them, and drawn as MultiMeshes in chunks, each tree as its model near and as its flat card far, nothing past the fog's end. Each trunk gets a cylinder, so the player walks round the trees.

**See it working:** the GIF on [the tutorial's page](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/grow-a-ps1-style-forest/).

**Script:** [`forest_grower.gd`](forest_grower.gd) · Godot 4.3 or newer

## How to use it

1. Add a `Node3D` and attach `forest_grower.gd`. Its area, `size`, is centred on the node.
2. Give it one entry per kind of tree in `meshes`, `cards` and `weights`: its model, its far card and how common it is. A kind without a card draws its model up to `fade_end`.
3. Draw your trails as `Path3D` curves and list them in `trails`: no trunk stands within `trail_margin` metres of a trail's middle.
4. Set `seed`, `trees_per_100m2` and `spacing` (no two trunks closer than that). The trees are models up to `far_distance` and cards from there to `fade_end`: put your fog's end at `fade_end`.
5. At runtime it grows by itself on its first physics frame (its rays down to the ground need the physics world); in the editor, tick `grow_now`. With `follow_ground` on, each tree stands on the collider below it, and where there is none there is no tree; off, the trees stand on the node's plane.

## What it needs

- Godot 4.3 or newer.
- Ground with collision under the area (any physics body), or `follow_ground` off; a model for each kind of tree, and a flat card for the far ones.

## Try it free

The [Cordatix PSX Horror Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) has two trees of Cordatix PSX Horror Forest with their far cards, the medium pine and the dead pine (`cordatix/psx_horror_forest/meshes/pine_medium.tres` and `dead_pine.tres`, their cards in `cordatix/psx_horror_forest/cards/`), in the forest's looks, and this script as `cordatix/psx_horror_forest/sampler/forest_grower.gd`. N in the sampler's demo room opens its forest taste: a night trail looping through a forest grown round it. The pack's own forest builder adds what a whole forest needs: undergrowth and rocks, slopes, clearings that level the ground, the rolling ground that carves the trails, the four looks at runtime, trail marks and the trail that loops when the player is lost.

## Tested

In Godot 4.3 and 4.7.2, on a slope with a trail across it, with the free sampler's pine and dead pine and their cards: it grows by itself on the first physics frame; one seed gives one forest and another seed another; no trunk stands within 2 m of the trail; every tree stands on the slope; each chunk draws its models to 45 m and its cards from 45 to 100 m; every trunk has its cylinder; where there is no ground there is no tree.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Grow a PS1-Style Forest in Godot 4 (Cordatix PSX Horror Forest)](https://cordatix.itch.io/cordatix-psx-horror-forest/devlog/1743440/how-to-grow-a-ps1-style-forest-in-godot-4-cordatix-psx-horror-forest) on itch.io, written for [Cordatix PSX Horror Forest](https://cordatix.itch.io/cordatix-psx-horror-forest), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
