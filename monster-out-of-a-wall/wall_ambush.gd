extends CharacterBody3D
## How to Make a Monster Step Out of a Wall in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/haunted-psx-monsters/devlog/1724922/how-to-make-a-monster-step-out-of-a-wall-in-godot-4-haunted-psx-monsters

## How close the player must come, and how far the Emerge clip carries the body out of the wall.
@export var trigger_range := 2.5
@export var step_out := 0.32

@onready var anim: AnimationPlayer = find_child("AnimationPlayer", true, false)
var waiting := true
var emerging := false
var armed := true          # back in the wall, it waits for the player to leave before it can step out again
var _home: Transform3D


func _ready() -> void:
	_home = global_transform
	hide_in_wall()


## Pressed flat on the wall: Emerge's first frame, held. The clip plays and seeks before it pauses (a paused
## player's seek would leave the skeleton as it was).
func hide_in_wall() -> void:
	global_transform = _home
	waiting = true
	emerging = false
	anim.play("Emerge")
	anim.seek(0.0, true)
	anim.pause()


## Near enough, it steps out: Emerge plays on, and the body moves out along its facing at the clip's pace, with no
## collisions (its capsule starts inside the wall).
func _physics_process(delta: float) -> void:
	var player := get_tree().get_first_node_in_group("player") as Node3D
	if waiting:
		var near := player != null and global_position.distance_to(player.global_position) < trigger_range
		if near and armed:
			waiting = false
			emerging = true
			anim.play("Emerge")
		elif not near:
			armed = true
		return
	if emerging:
		var length := anim.get_animation("Emerge").length
		global_position += -global_transform.basis.z * step_out / length * delta
		if not anim.is_playing():
			emerging = false
			anim.play("Idle")


## Once the player looks away from it and from its place on the wall, it slips back in.
func _process(_delta: float) -> void:
	if waiting or emerging:
		return
	var cam := get_viewport().get_camera_3d()
	if cam and not cam.is_position_in_frustum(global_position + Vector3.UP) \
			and not cam.is_position_in_frustum(_home.origin + Vector3.UP):
		hide_in_wall()
		armed = false
