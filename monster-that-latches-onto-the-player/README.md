# How to Make a Monster That Latches onto the Player in Godot 4

![The Latching of PSX Horror Swarms in Godot 4 with the PSX look: a giant leech of worms comes across a cellar, rears its front, lunges with its toothed sucker open and latches onto the player's chest; three shots knock it off, it bursts into its worms, and they gather and come again](latching_monster.gif)

One script that hunts, rears, lunges, holds on and lets go, with any mesh: the monster glides along the floor at its target, rears its front up when it is near, lunges, latches onto the target's chest and bites on time until quick hits knock it off; knocked off, it falls, lies still a moment and comes again.

**Script:** [`latching_monster.gd`](latching_monster.gd) · Godot 4.3 or newer

## How to use it

1. Add a `Node3D`, attach `latching_monster.gd` and put your monster's mesh under it (its front -Z, its pivot at its tail end, so rearing tips its front up).
2. Set `target` to your player: its `take_damage(amount, from)` takes the bites.
3. Your weapons call `hit(amount)` on it: damage adds up while the hits come quickly, and enough of it while it holds on knocks it off.
4. Tune the distances it changes its mind at (where it rears, where it lunges), the height it holds on at and how hard it is to shake off.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- A target with `take_damage(amount, from)`.

## Try it free

The [Cordatix PSX Horror Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) has a small swarm of PSX Horror Swarms' worms, not The Latching: the code works on any mesh of yours.

## Tested

In Godot 4.3 and 4.7.2 with a stand-in target: it glides at its target and rears at the rear distance, its mesh tipped up; it lunges and latches onto the chest; it bites on time; it holds on as its target walks and turns; slow hits do not knock it off and three quick ones do; it falls to the floor, lies still, and comes again.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Make a Monster That Latches onto the Player in Godot 4 (PSX Horror Swarms 2.0)](https://cordatix.itch.io/cordatix-psx-horror-swarms/devlog/1774519/how-to-make-a-monster-that-latches-onto-the-player-in-godot-4-psx-horror-swarms) on itch.io, written for [PSX Horror Swarms](https://cordatix.itch.io/cordatix-psx-horror-swarms), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
