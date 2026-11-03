# Cordatix PSX Tutorials: PS1 Horror Scripts

The Godot 4 scripts of the Cordatix devlogs, for PS1-style (PSX) horror and liminal games, as one addon: 23 tutorials, each a folder with its GDScript and a README (what it does, how to use it, what it needs, which free sampler has a scene to try it on). MIT licensed: use the code in any project, commercial ones too.

Godot 4.3 or newer; the Compatibility renderer is enough. Every script is tested in Godot 4.3 and 4.7.2.

## The tutorials

| Folder | What it does | Written for |
|---|---|---|
| [`switch-a-whole-house-from-lived-in-to-abandoned`](switch-a-whole-house-from-lived-in-to-abandoned/README.md) | Every prop under a house swaps for the same prop years later, in place, and the house's walls and windows age with them: one property, one node | [Cordatix PSX Horror Village](https://cordatix.itch.io/cordatix-psx-horror-village) |
| [`make-a-swarm-monster`](make-a-swarm-monster/README.md) | Hundreds of worms in one MultiMesh, one draw call: each crawls to its own place in the swarm's shape, a blow throws the nearest off, and they crawl back | [Cordatix PSX Horror Swarms](https://cordatix.itch.io/cordatix-psx-horror-swarms) |
| [`re-finish-a-house`](re-finish-a-house/README.md) | Name a model's surfaces by their role and give a node a table of names and texture families: every surface takes its material, and one property swaps the whole house from lived in to abandoned | [Cordatix PSX Horror Village Textures](https://cordatix.itch.io/cordatix-psx-horror-village-textures) |
| [`light-up-the-house-the-player-just-left`](light-up-the-house-the-player-just-left/README.md) | Walk out of a house and, behind your back, its windows glow and a lamp burns inside; come near it again and it goes dark before you reach its door | [Cordatix PSX Horror Village](https://cordatix.itch.io/cordatix-psx-horror-village) |
| [`grow-a-ps1-style-forest`](grow-a-ps1-style-forest/README.md) | Trees scattered over an area by a seed, kept off the trails you draw and set on the ground, drawn as MultiMeshes in chunks: models near, flat cards far | [Cordatix PSX Horror Forest](https://cordatix.itch.io/cordatix-psx-horror-forest) |
| [`lock-the-player-in-a-boss-arena`](lock-the-player-in-a-boss-arena/README.md) | An Area3D over an arena's floor: the gates slam down behind the player and the boss starts, they rise when it dies, and the player's death puts the fight back as it was | [Cordatix PSX Horror Boss Arena](https://cordatix.itch.io/cordatix-psx-horror-boss-arena) |
| [`boss-fight-with-phases`](boss-fight-with-phases/README.md) | A boss's health, phases that begin at a share of it with a transition clip, and each phase's attacks drawn by weight, never the same three times running | [Cordatix PSX Horror Bosses](https://cordatix.itch.io/cordatix-psx-horror-bosses) |
| [`several-packs-in-one-project`](several-packs-in-one-project/README.md) | Several asset packs in one Godot project, and a script that sets the light limits, filters and navigation cells they ask for | [Cordatix PSX Mega Pack](https://cordatix.itch.io/cordatix-psx-mega-pack) |
| [`npcs-turn-their-heads`](npcs-turn-their-heads/README.md) | A person's chest, neck and head turn to the player who comes near, over whatever clip plays | [PSX Bystanders NPC Pack](https://cordatix.itch.io/psx-bystanders-npc-pack) |
| [`anomaly-tutorial-run`](anomaly-tutorial-run/README.md) | The first levels of a run set in advance, each with a hint for the player, then the draw takes over | [Liminal PSX Parking Anomalies](https://cordatix.itch.io/liminal-psx-parking-anomalies) |
| [`anomaly-loop-behind-a-menu`](anomaly-loop-behind-a-menu/README.md) | The loop waits behind your title menu: nothing happens before Start, and the floor behind the menu is the one the run starts on | [Liminal PSX Anomalies](https://cordatix.itch.io/liminal-psx-anomalies) |
| [`anomalies-without-repeats`](anomalies-without-repeats/README.md) | Which anomaly a level shows: none twice before all have come, the obvious ones early, the subtle ones late | [Liminal PSX Parking Anomalies](https://cordatix.itch.io/liminal-psx-parking-anomalies) |
| [`looping-hallway`](looping-hallway/README.md) | One hallway between two stairwells built alike: walk on and you are in it again, a floor lower | [Liminal PSX Anomalies](https://cordatix.itch.io/liminal-psx-anomalies) |
| [`hide-in-a-locker`](hide-in-a-locker/README.md) | Hide the player in a locker; a chasing creature loses them, and can search the lockers | [Cordatix PSX Horror Spaces](https://cordatix.itch.io/haunted-psx-spaces) |
| [`move-only-when-unseen`](move-only-when-unseen/README.md) | Something that changes only while nobody looks at it | [Silent Dread](https://cordatix.itch.io/silent-dread) |
| [`doors-that-open-away`](doors-that-open-away/README.md) | A door that swings away from the player, from either side | [Liminal PSX Office Kit](https://cordatix.itch.io/liminal-psx-office-kit) |
| [`monster-out-of-a-wall`](monster-out-of-a-wall/README.md) | A monster that waits flat on a wall, steps out, and slips back unseen | [Cordatix PSX Horror Monsters](https://cordatix.itch.io/haunted-psx-monsters) |
| [`rot-a-room`](rot-a-room/README.md) | A room that decays while the player is away, and a decal where they look | [Cordatix PSX Horror Interior Textures](https://cordatix.itch.io/haunted-psx-interior-textures) |
| [`ps1-liminal-room`](ps1-liminal-room/README.md) | Crisp PS1 textures, a metre scale, office light and a low-resolution PSX look | [Liminal PSX Textures](https://cordatix.itch.io/liminal-psx-textures) |
| [`gridmap-office-level`](gridmap-office-level/README.md) | Paint a level from 2 m pieces with GridMap, with lights and doors | [Liminal PSX Office Kit](https://cordatix.itch.io/liminal-psx-office-kit) |
| [`furnish-an-office`](furnish-an-office/README.md) | Place props, swap their states in place, and push them around | [Liminal PSX Office Props](https://cordatix.itch.io/liminal-psx-office-props) |
| [`festive-and-creepy`](festive-and-creepy/README.md) | One key turns a Halloween party into its abandoned aftermath | [Cordatix PSX Horror Halloween Takeover](https://cordatix.itch.io/haunted-psx-halloween-takeover) |
| [`pickups-and-inventory`](pickups-and-inventory/README.md) | Pick items up with a look and a key, and show them in an inventory bar | [Cordatix PSX Horror Props](https://cordatix.itch.io/haunted-psx-props) |

## What is here, and what is not

Only code and text. No model, texture or scene of any pack is in this addon. Most of the scripts work with any models of your own; a few use files of a Cordatix pack (a MeshLibrary, a decal, a setup), and each README says which, and which free sampler on itch.io has them.

No script runs until you use it: the addon has no plugin to enable. Copy a script where you want it, or attach it from here.

Each tutorial's page, with a GIF of it working: [https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/). The free samplers: [https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/samplers.html](https://goldensparrow-dev.github.io/cordatix-godot-psx-tutorials/samplers.html).

## How it was made

The scripts were written with an AI model (Claude, by Anthropic) and tested by running them in Godot 4.3 and 4.7.2 on the free samplers' scenes. The Cordatix asset packs that the READMEs and pictures show disclose their AI-generated graphics on their itch.io pages.

## License

MIT: see [LICENSE](LICENSE). The pictures of Cordatix asset packs that the READMEs link to are not covered by it.

## Cordatix

PS1-style asset packs for Godot 4, Unity, Unreal and Blender, each with a free sampler: [cordatix.itch.io](https://cordatix.itch.io). The tutorials' repository: [https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials](https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials).
