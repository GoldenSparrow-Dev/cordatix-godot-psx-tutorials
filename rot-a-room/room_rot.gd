extends Node3D
## How to Rot a Room at Run Time in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/haunted-psx-interior-textures/devlog/1722195/how-to-rot-a-room-at-run-time-in-godot-4-haunted-psx-interior-textures

const Decay := preload("res://cordatix/haunted_psx_interior_textures/scripts/decay_swap.gd")


## The room this script rots, and the area the player leaves it through.
@export var room: Node3D
@export var doorway: Area3D

var rotted := false


func _ready() -> void:
	doorway.body_exited.connect(_on_left)


## When the player walks out, every surface of the pack in the room turns heavy, once.
func _on_left(body: Node3D) -> void:
	if rotted or not body.is_in_group("player"):
		return
	rotted = true
	Decay.set_level(room, "heavy")


const HANDPRINT := preload("res://cordatix/haunted_psx_interior_textures/decals/decal_blood_handprint.tscn")


## A decal on whatever the camera looks at: a quad 2 mm off the surface, turned to face out of it.
func mark_wall(camera: Camera3D) -> void:
	var from := camera.global_position
	var to := from - camera.global_basis.z * 3.0
	var hit := get_world_3d().direct_space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
	if hit.is_empty():
		return
	var n: Vector3 = hit["normal"]
	var decal: Node3D = HANDPRINT.instantiate()
	add_child(decal)
	var up := Vector3.UP if absf(n.dot(Vector3.UP)) < 0.99 else Vector3.FORWARD
	decal.global_transform = Transform3D(Basis.looking_at(-n, up), hit["position"])
