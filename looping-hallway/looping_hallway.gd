extends Node
## How to Make a Hallway That Loops for an Anomaly Game in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/liminal-psx-anomalies/devlog/1729533/how-to-make-a-hallway-that-loops-for-an-anomaly-game-in-godot-4-liminal-psx-anomalies
## A hallway that loops: when the player is a flight down (or up) either stairwell, out of sight of the hallway,
## they are moved to the same place a storey back in the stairwell they came in by, so they walk down into the same
## hallway again. Build the two stairwells alike, their storeys `storey` metres apart; `back` and `on` mark the same
## spot in each (the middle of the stairwell's door, its +Z into the stairwell).

signal chosen(went_on: bool)

@export var player: CharacterBody3D
## A marker in the stairwell the player came in by, and the same spot in the far one.
@export var back: Node3D
@export var on: Node3D
## The height between two storeys, and how far below (or above) the hallway's floor the move happens.
@export var storey := 4.0
@export var cross_depth := 1.75
## The inside of a stairwell in its marker's frame (x, z).
@export var inside := Rect2(-1.9, 0.1, 3.8, 5.8)

var armed := false                    # only a player who has stood in the hallway can choose


func _physics_process(_delta: float) -> void:
	if player == null:
		return
	if not armed and _in_hallway(player.global_position):
		armed = true
	if not armed:
		return
	for s in [back, on]:
		var p: Vector3 = s.global_transform.affine_inverse() * player.global_position
		if inside.has_point(Vector2(p.x, p.z)) and absf(p.y) >= cross_depth:
			_move(s, p.y < 0.0)
			return


func _in_hallway(at: Vector3) -> bool:
	for s in [back, on]:
		var p: Vector3 = s.global_transform.affine_inverse() * at
		if inside.has_point(Vector2(p.x, p.z)) or absf(p.y) > 0.5:
			return false
	return true


## The move: from the stairwell s to the same place in `back`, a storey up (down, if they climbed). The player keeps
## their place in the stairwell, their view and their speed.


func _move(s: Node3D, down: bool) -> void:
	var lift := Transform3D(Basis(), Vector3(0.0, storey if down else -storey, 0.0))
	var t := back.global_transform * lift * s.global_transform.affine_inverse()
	player.global_transform = t * player.global_transform
	player.velocity = t.basis * player.velocity
	player.reset_physics_interpolation()
	armed = false
	chosen.emit(s == on)
