# How to Make a Monster Hide Until a Flashlight Finds It in Godot 4

A monster you can hardly see in the dark until your flashlight finds it. The script gives each mesh of the model its own copy of every material, so revealing one monster does not light every other copy of the same model, and adds a glow made from the model's own colours. Every physics frame it asks each flashlight whether its beam reaches three points on the body: within the light's range, inside its cone and with nothing in between. It shows fast and fades back slowly, so a player who swings the light past sees it a moment too late.

**See it working:** the GIF on [the tutorial's page](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/monster-hidden-until-the-flashlight-finds-it/).

**Script:** [`flashlight_reveal.gd`](flashlight_reveal.gd) · Godot 4.3 or newer

## How to use it

1. Make the monster a CharacterBody3D with its model under it, and attach `flashlight_reveal.gd` to the CharacterBody3D.
2. Put your player's flashlight, a `SpotLight3D`, in the group `flashlight`. Any number of lights count.
3. Tune `dark` (its colours in the dark, times this), `glow`, `fade_in` and `fade_out` (seconds), and `heights`: where on the body the beam can find it, in metres up.
4. A material with a glow map of its own (glowing eyes) keeps it: those still glow in the dark.

## What it needs

- Godot 4.3 or newer (the Compatibility renderer is enough).
- A model with StandardMaterial3D materials; any rigged or static model works.

## Try it free

The Cordatix PSX Horror Free Sampler has Papered, a figure of peeling wallpaper, with all ten of its clips and the enemy script: the code works on it as it is. In the full pack Lint, a figure of house dust, does the same through its enemy script's `show_in_light` settings.

## Tested

In Godot 4.3 and 4.7.2, with Papered from the free sampler: in the dark it stays dim; the beam finds it and it shows within `fade_in` while another copy of the same model stays as it was; it fades back, not at once, when the beam leaves; beside the beam, behind a wall, beyond the beam's range or with the flashlight off it stays dark; the body carrying the light never blocks it.

## The devlog and the pack

The step-by-step walkthrough is the devlog [How to Make a Monster Hide Until a Flashlight Finds It in Godot 4 (Cordatix PSX Horror Monsters 2.0)](https://cordatix.itch.io/haunted-psx-monsters/devlog/1764265/how-to-make-a-monster-that-hides-until-your-flashlight-finds-it-in-godot-4-cordatix-psx-horror-monsters) on itch.io, written for [Cordatix PSX Horror Monsters](https://cordatix.itch.io/haunted-psx-monsters), a PS1-style asset pack by [Cordatix](https://cordatix.itch.io) for Godot 4, Unity, Unreal and Blender.

The code is MIT licensed ([LICENSE](../LICENSE)). The pictures show Cordatix asset packs and are not covered by the MIT license.
