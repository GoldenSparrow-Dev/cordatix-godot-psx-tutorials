# Cordatix Godot 4 PSX Tutorials

Godot 4 scripts from the Cordatix devlogs, for PS1-style (PSX) horror and liminal games. Each folder is one tutorial: its GDScript, a GIF of it working, how to use it, what it needs, and a link to the devlog that walks through it on itch.io. The code is MIT licensed: use it in any project, commercial ones too.

## Tutorials

| Tutorial | What it does | Written for | Try it free with |
|---|---|---|---|
| [Script a Tutorial Run for an Anomaly Game](anomaly-tutorial-run/) | The first levels of a run set in advance, each with a hint for the player, then the draw takes over | [Liminal PSX Parking Anomalies](https://cordatix.itch.io/liminal-psx-parking-anomalies) | [Liminal PSX Parking Anomalies Free Sampler](https://cordatix.itch.io/liminal-psx-parking-anomalies-free) |
| [Start an Anomaly Loop Behind a Menu](anomaly-loop-behind-a-menu/) | The loop waits behind your title menu: nothing happens before Start, and the floor behind the menu is the one the run starts on | [Liminal PSX Anomalies](https://cordatix.itch.io/liminal-psx-anomalies) | [Liminal PSX Anomalies Free Sampler](https://cordatix.itch.io/liminal-psx-anomalies-free) |
| [Draw Anomalies Without Repeats](anomalies-without-repeats/) | Which anomaly a level shows: none twice before all have come, the obvious ones early, the subtle ones late | [Liminal PSX Parking Anomalies](https://cordatix.itch.io/liminal-psx-parking-anomalies) | [Liminal PSX Parking Anomalies Free Sampler](https://cordatix.itch.io/liminal-psx-parking-anomalies-free) |
| [Make a Hallway That Loops for an Anomaly Game](looping-hallway/) | One hallway between two stairwells built alike: walk on and you are in it again, a floor lower | [Liminal PSX Anomalies](https://cordatix.itch.io/liminal-psx-anomalies) | [Liminal PSX Anomalies Free Sampler](https://cordatix.itch.io/liminal-psx-anomalies-free) |
| [Hide in a Locker](hide-in-a-locker/) | Hide the player in a locker; a chasing creature loses them, and can search the lockers | [Haunted PSX Spaces](https://cordatix.itch.io/haunted-psx-spaces) | a locker scene of your own (see its README) |
| [Make Something Move Only When the Player Looks Away](move-only-when-unseen/) | Something that changes only while nobody looks at it | [Silent Dread](https://cordatix.itch.io/silent-dread) | [Silent Dread Free Sampler](https://cordatix.itch.io/silent-dread-free) |
| [Make Doors Open Away from the Player](doors-that-open-away/) | A door that swings away from the player, from either side | [Liminal PSX Office Kit](https://cordatix.itch.io/liminal-psx-office-kit) | [Liminal PSX Office Kit - Free Sampler](https://cordatix.itch.io/liminal-psx-office-kit-free) |
| [Make a Monster Step Out of a Wall](monster-out-of-a-wall/) | A monster that waits flat on a wall, steps out, and slips back unseen | [Haunted PSX Monsters](https://cordatix.itch.io/haunted-psx-monsters) | [Haunted PSX Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) |
| [Rot a Room at Run Time](rot-a-room/) | A room that decays while the player is away, and a decal where they look | [Haunted PSX Interior Textures](https://cordatix.itch.io/haunted-psx-interior-textures) | [Haunted PSX Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) |
| [Build a PS1-Style Liminal Room](ps1-liminal-room/) | Crisp PS1 textures, a metre scale, office light and a low-resolution PSX look | [Liminal PSX Textures](https://cordatix.itch.io/liminal-psx-textures) | [Liminal PSX Textures - Free Sampler](https://cordatix.itch.io/liminal-psx-textures-free) |
| [Build a Liminal Office Level with GridMap](gridmap-office-level/) | Paint a level from 2 m pieces with GridMap, with lights and doors | [Liminal PSX Office Kit](https://cordatix.itch.io/liminal-psx-office-kit) | [Liminal PSX Office Kit - Free Sampler](https://cordatix.itch.io/liminal-psx-office-kit-free) |
| [Furnish a Liminal Office](furnish-an-office/) | Place props, swap their states in place, and push them around | [Liminal PSX Office Props](https://cordatix.itch.io/liminal-psx-office-props) | [Liminal PSX Office Props - Free Sampler](https://cordatix.itch.io/liminal-psx-office-props-free) |
| [Switch a Room Between Festive and Creepy](festive-and-creepy/) | One key turns a Halloween party into its abandoned aftermath | [Haunted PSX Halloween Takeover](https://cordatix.itch.io/haunted-psx-halloween-takeover) | [Haunted PSX Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) |
| [Make Pickups With Inventory Icons](pickups-and-inventory/) | Pick items up with a look and a key, and show them in an inventory bar | [Haunted PSX Props](https://cordatix.itch.io/haunted-psx-props) | [Haunted PSX Free Sampler](https://cordatix.itch.io/haunted-psx-free-sampler) |

## Using the code

Godot 4.3 or newer. Copy a folder's script into your project and follow its README. Most of the scripts work with any models; a few use files of a Cordatix pack (a MeshLibrary, a decal, a setup), and each README says which, and which free sampler has them.

## What is here, and what is not

Only code, and pictures of it working. No model, texture or scene of any pack is in this repository: the free samplers on itch.io have the files to try the scripts with, or use your own.

## License

The code is MIT licensed: see [LICENSE](LICENSE). The GIFs and pictures show Cordatix asset packs and are not covered by the MIT license.

## Cordatix

PS1-style asset packs for Godot 4, Unity, Unreal and Blender, each with a free sampler: [cordatix.itch.io](https://cordatix.itch.io). A new pack's Godot tutorial joins this repository when its devlog is published.

## The website

The same tutorials as a website, with the free samplers and the packs: https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/
