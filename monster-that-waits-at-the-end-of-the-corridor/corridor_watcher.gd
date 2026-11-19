class_name CorridorWatcher
extends CharacterBody3D
## How to Make a Monster That Waits at the End of the Corridor in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## Written for: https://cordatix.itch.io/liminal-psx-entities
## A monster that waits at the end of the corridor, in Godot 4.3+. While you can see it and come closer than `near`,
## it backs away, still facing you; while your back is turned it follows, up to `near`; farther than `far` it follows
## whether you look or not. It never comes closer while you watch it.
## Give it a NavigationAgent3D child named "NavigationAgent3D" and a collision shape; put the player in the group
## "player" (its Camera3D is the current camera). If the model has an AnimationPlayer with "Idle", "Walk" and "Retreat"
## (a walk played backwards), they play; Liminal PSX Entities' Watcher has all three.

@export var near := 7.0
@export var far := 12.0
@export var walk_speed := 0.9
@export var retreat_speed := 0.7
## The heights (m) where it checks whether the camera sees it: its chest and its head.
@export var look_points: Array[float] = [1.2, 2.4]

var player: Node3D
var anim: AnimationPlayer
var phase := ""
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)
@onready var agent: NavigationAgent3D = $NavigationAgent3D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Node3D
	anim = find_child("AnimationPlayer", true, false) as AnimationPlayer


func is_seen() -> bool:
	## Seen: one of its look points is inside the camera's view, and nothing stands between the camera and it.
	var cam := get_viewport().get_camera_3d()
	if cam == null:
		return false
	var space := get_world_3d().direct_space_state
	for h in look_points:
		var at: Vector3 = global_position + Vector3.UP * h
		if not cam.is_position_in_frustum(at):
			continue
		var q := PhysicsRayQueryParameters3D.create(cam.global_position, at)
		var skip: Array[RID] = [get_rid()]           # itself and the player's own body are not in the way
		if player is CollisionObject3D:
			skip.append((player as CollisionObject3D).get_rid())
		q.exclude = skip                              # set the whole list: the getter returns a copy
		if space.intersect_ray(q).is_empty():
			return true
	return false


func _physics_process(delta: float) -> void:
	if player == null:
		return
	var to := player.global_position - global_position
	to.y = 0.0
	var d := to.length()
	var seen := is_seen()
	var move := Vector3.ZERO
	if seen and d < near:
		phase = "retreat"                      # back away, still facing them
		move = -to.normalized() * retreat_speed
	elif (not seen and d > near) or d > far:
		phase = "follow"                       # along the navigation mesh, to them
		agent.target_position = player.global_position
		var next := agent.get_next_path_position()
		var step := next - global_position
		step.y = 0.0
		if step.length() < 0.05:
			step = to                          # no navigation mesh: straight at them
		move = step.normalized() * walk_speed
	else:
		phase = "watch"
	_play({"retreat": "Retreat", "follow": "Walk", "watch": "Idle"}[phase])
	if d > 0.1:
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	velocity.x = move.x
	velocity.z = move.z
	velocity.y = 0.0 if is_on_floor() else velocity.y - gravity * delta
	move_and_slide()


func _play(clip: String) -> void:
	if anim and anim.has_animation(clip) and anim.current_animation != clip:
		anim.play(clip, 0.2)
