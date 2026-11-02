class_name HouseYears
extends Node
## How to Switch a Whole House from Lived In to Abandoned in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/cordatix-psx-horror-village/devlog/1747801/how-to-switch-a-whole-house-from-lived-in-to-abandoned-in-godot-4-cordatix-psx-horror-village-11
## Switch a whole house between lived in and abandoned (Godot 4.3+). MIT licence.
## Every prop of Cordatix PSX Horror Village comes twice: as it was the night before the village was left, and
## the same prop years later, both with one origin. data/props.json pairs each lived scene with its abandoned twin. Put
## this node under a house: setting `state` swaps every prop under the house for its twin in place, and hands the
## state on to any re-finish node in the house (a node with a `state` and an `apply()`, such as the free sampler's
## surface_finish.gd), so the walls age with the furniture, and to the house itself when it is Cordatix PSX Horror
## Village's house builder (a `state` and a `build()`): its windows break and board with the years.

## The pack's folder: its data/props.json and props/ scenes.
@export_dir var pack := "res://cordatix/psx_horror_village_props"
@export_enum("lived", "abandoned") var state := "lived":
	set(v):
		state = v
		if is_inside_tree():
			apply()


var _twin := {}            # scene path -> its other side's scene path, both ways


func _ready() -> void:
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(pack + "/data/props.json"))
	for p in data["props"]:
		for lived in p["pairs"]:
			var dead: String = p["pairs"][lived]
			for kind in ["", "__pickup", "__use", "__rigid"]:
				var a := "%s/props/%s%s.tscn" % [pack, lived, kind]
				var b := "%s/props/%s%s.tscn" % [pack, dead, kind]
				if ResourceLoader.exists(a) and ResourceLoader.exists(b):
					_twin[a] = b
					_twin[b] = a
	apply()


## Swaps every prop under the parent onto the side `state` names; returns how many it swapped.
func apply() -> int:
	var n := 0
	for node in get_parent().find_children("*", "Node3D", true, false):
		var path: String = node.scene_file_path
		if not _twin.has(path) or _is_side(path) == state or _gone(node):
			continue
		var twin: Node3D = (load(_twin[path]) as PackedScene).instantiate()
		twin.transform = (node as Node3D).transform
		var parent := node.get_parent()
		var at := node.get_index()
		var nm := node.name
		node.name = String(nm) + "_old"
		parent.add_child(twin)
		parent.move_child(twin, at)
		twin.name = nm
		node.queue_free()
		n += 1
	for f in get_parent().find_children("*", "", true, false):
		if f != self and f.has_method("apply") and "state" in f:
			f.set("state", state)
	var house := get_parent()
	if house.has_method("build") and "state" in house and house.get("state") != state:
		house.set("state", state)
		house.call("build")
	return n


func _gone(node: Node) -> bool:
	while node != null:
		if node.is_queued_for_deletion():
			return true
		node = node.get_parent()
	return false


func _is_side(path: String) -> String:
	return "abandoned" if path.get_file().get_basename().contains("abandoned") else "lived"
