extends Node
## How to Make a Curse Spread Through a Room in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/haunted-psx-props/devlog/1765998/how-to-make-a-curse-spread-through-a-room-in-godot-4-cordatix-psx-horror-props
## Spreads a curse through a room: every prop under `room` that has a cursed (or creepy) state turns, one at a time,
## the nearest to `source` first. Works with every Cordatix PSX Horror pack that has a switch (its data/props.json).

const Sides := preload("res://cordatix/shared/scripts/cordatix_sides.gd")

@export var pack := "res://cordatix/haunted_psx_props/"   # the pack folder, with its trailing slash
@export var room: Node3D                                  # the props to turn are anywhere under it
@export var source: Node3D                                # where the curse starts
@export var step := 0.3                                   # seconds between two props
@export var radius := 0.0                                 # only props this close to the source; 0: all of them

signal turned(prop: Node3D)                               # each prop as it turns (a sound, a flicker)
signal finished

var spreading := false


## The props under `room` that can still turn: placed as a prop's first state (normal, festive, lit), shown, and
## within `radius` of the source when it is set.
func turnable() -> Array[Node3D]:
	var first := {}
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(pack + "data/props.json"))
	for p in data["props"]:
		for v in p["pairs"]:
			first[v] = true
	var out: Array[Node3D] = []
	for n in room.find_children("*", "Node3D", true, false):
		if not first.has(variant_of(n)) or not n.is_visible_in_tree():
			continue
		if radius > 0.0 and n.global_position.distance_to(source.global_position) > radius:
			continue
		out.append(n)
	return out


## A placed prop's variant: its scene's file name without the physics, flicker, pickup or lock suffix.
static func variant_of(n: Node) -> String:
	var f := n.scene_file_path.get_file().get_basename()
	for sfx in ["__rigid", "__flicker", "__pickup", "__use"]:
		f = f.trim_suffix(sfx)
	return f


## Turns every turnable prop, nearest first, `step` seconds apart.
func spread() -> void:
	if spreading:
		return
	spreading = true
	var props := turnable()
	var at := source.global_position
	props.sort_custom(func(a: Node3D, b: Node3D) -> bool:
		return a.global_position.distance_squared_to(at) < b.global_position.distance_squared_to(at))
	for p in props:
		if not is_instance_valid(p):
			continue
		turned.emit(Sides.swap_in_place(p, pack))
		await get_tree().create_timer(step).timeout
	spreading = false
	finished.emit()
