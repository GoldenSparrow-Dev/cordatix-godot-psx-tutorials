class_name SurfaceFinish
extends Node
## How to Re-Finish a House in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/cordatix-psx-horror-village-textures/devlog/1745146/how-to-re-finish-a-house-in-godot-4-cordatix-psx-horror-village-textures
## Re-finish a house by its surfaces' names (Godot 4.3+). A mesh's surfaces can carry names: an ArrayMesh's
## surface_get_name() (the material's name in a glTF, the role a kit gave each part). This node sets a material
## override on every surface under its parent whose name is in `finishes`, so one model takes a new finish in place,
## and it swaps every finished surface between states (lived and abandoned) by the materials' file names:
## <folder>/<family>_<state>.tres.


## Which surface takes which texture family, e.g. {"vi_wall_out": "wall_limewash_blue", "vi_roof": "roof_tiles_clay"}.
@export var finishes: Dictionary = {}
## Where the materials are: <folder>/<family>_<state>.tres.
@export_dir var folder := "res://cordatix/psx_horror_village_textures/materials"
@export_enum("lived", "abandoned") var state := "lived":
	set(v):
		state = v
		if is_inside_tree():
			apply()


func _ready() -> void:
	apply()


## Sets the finishes on every surface named in `finishes` under the parent; returns how many it set.
func apply() -> int:
	var n := 0
	for node in get_parent().find_children("*", "MeshInstance3D", true, false):
		var mi := node as MeshInstance3D
		var mesh := mi.mesh as ArrayMesh
		if mesh == null:
			continue
		for i in mesh.get_surface_count():
			var family: Variant = finishes.get(mesh.surface_get_name(i))
			if family == null:
				continue
			var path := "%s/%s_%s.tres" % [folder, family, state]
			if not ResourceLoader.exists(path):
				continue                  # no material for this family in this state: the surface keeps its own
			mi.set_surface_override_material(i, load(path) as Material)
			n += 1
	return n
