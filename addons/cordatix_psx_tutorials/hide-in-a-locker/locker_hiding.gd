extends Node3D
## How to Hide in a Locker in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/haunted-psx-spaces/devlog/1722819/how-to-hide-in-a-locker-in-godot-4-haunted-psx-spaces

## The chasing creature (any node with a `target` property) and the player's camera.
@export var creature: Node3D
@export var camera: Camera3D

var _eye: Transform3D


func _ready() -> void:
	for locker in get_tree().get_nodes_in_group("lockers"):
		locker.player_hidden.connect(_on_hidden.bind(locker))
		locker.player_left.connect(_on_left)


## Shut in: the creature loses the player, and the camera looks out through the vents.
func _on_hidden(_body: Node3D, locker: Node3D) -> void:
	creature.set("target", null)
	_eye = camera.transform
	camera.global_transform = locker.peek_point().global_transform


## Out again: the camera goes back to the player's eyes, and the creature is after the player.
func _on_left(body: Node3D) -> void:
	camera.transform = _eye
	creature.set("target", body)


## A creature that searches a room can open the lockers someone hides in: is_occupied() says so.
func search(locker: Node3D, player: Node3D) -> void:
	if locker.is_occupied():
		locker.interact(creature)
		creature.set("target", player)
