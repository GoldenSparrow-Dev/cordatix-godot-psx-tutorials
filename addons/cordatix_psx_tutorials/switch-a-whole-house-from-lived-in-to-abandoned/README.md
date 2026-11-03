# How to Switch a Whole House from Lived In to Abandoned in Godot 4

An abandoned house is scarier when the player has seen it lived in. If every prop comes twice, as it was the night before the house was left and the same prop years later, with one origin, a whole house can switch with one property. This node reads the pairs from a JSON file once, and setting its state swaps every prop under the house for its twin in place: the same transform, the same name, the same place among its siblings. Then it hands the state on to any node in the house that has a state and an apply() (a re-finish script, so the walls age with the furniture), and to the house itself when the house is a builder with a state and a build().

**See it working:** the GIF on [the tutorial's page](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/switch-a-whole-house-from-lived-in-to-abandoned/).

**Script:** [`house_years.gd`](house_years.gd) · Godot 4.3 or newer

**In this addon** the script has no `class_name` line: the tutorial makes it the global class `HouseYears`, and a Cordatix pack or free sampler in your project may declare that class already (Godot takes each class name once). Where the steps below name the class, add `class_name HouseYears` above `extends` in your copy if no pack in the project declares it.

## How to use it

1. Add a `Node` under the house (or under a row of houses) and attach `house_years.gd`; its class is `HouseYears`. It switches every prop under its parent.
2. Give your props two scenes each, with one origin, in `<pack>/props/`: `chair.tscn` lived in and its twin `chair__abandoned.tscn` (the abandoned one's file name holds `abandoned`). Pair them in `<pack>/data/props.json` as `{"props": [{"pairs": {"chair": "chair__abandoned"}}]}`. A prop's pickup, use and rigid scenes pair the same way when both sides have them: `loaf__pickup.tscn` with `loaf__abandoned__pickup.tscn`.
3. Set `pack` to the folder that holds `data/props.json` and `props/`.
4. Set `state` to `lived` or `abandoned`: every prop under the house swaps at once. Switch behind a fade or a blink, and call `apply()` again after you add props at run time. A prop the player took is gone, so it stays gone when the house switches back.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- Props as pairs of scenes, lived in and abandoned, with one origin, and a `data/props.json` that pairs them.
- For the walls to age too: a node in the house with a `state` and an `apply()` (a re-finish script).

## Try it free

The [Cordatix PSX Horror Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) carries this script as `cordatix/psx_horror_village_props/sampler/house_years.gd`, with six of the village's props in both states (a kitchen table and chair, a portable television, a kettle, a jar of preserves and a loaf, the jar and the loaf to take) and the re-finish script `surface_finish.gd`, so a wall ages with them. In that project use the file as it is, or drop the `class_name` line from a copy of your own: Godot takes each class name once. The pack's 107 props come in both states, with things to take and to open, ready-made scenes and the kit's seven ready houses furnished.

## Tested

In Godot 4.3 and 4.7.2, in the free sampler's project, on stand-in props and on the sampler's six props by a wall of the free village pieces with the sampler's re-finish script: abandoned, every prop is its twin where it stood, turned as it was, a pickup stays a pickup, the wall wears its abandoned textures, nothing is doubled, a thing the player took stays gone when the house switches back, and a house builder is rebuilt once in the new state.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Switch a Whole House from Lived In to Abandoned in Godot 4 (Cordatix PSX Horror Village 1.1)](https://cordatix.itch.io/cordatix-psx-horror-village/devlog/1747801/how-to-switch-a-whole-house-from-lived-in-to-abandoned-in-godot-4-cordatix-psx-horror-village-11) on itch.io, written for [Cordatix PSX Horror Village](https://cordatix.itch.io/cordatix-psx-horror-village), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
