class_name NightTurn
extends Node3D
## How to Turn an NPC into an Enemy at Nightfall in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/psx-horror-villagers/devlog/1754522/how-to-turn-an-npc-into-an-enemy-at-nightfall-in-godot-4-psx-horror-villagers
## Turn a villager at nightfall in Godot 4.3+: by day one body, by night another, handed over in the same pose.
## Give this node two children, "Day" and "Night": two instances of one villager's model, each with its own
## AnimationPlayer (a PSX Horror Villagers GLB carries both bodies' clips: the day's as Day_<name>, the night's, and
## Turn). The day body plays Turn, a clip that ends on the night's first Idle frame; on that last frame the night body
## takes its place, so the hand-over shows no jump. Set `darkness` from your sky, 0 (day) to 1 (night): the villager
## turns when it reaches turn_at and comes back when it falls to dawn_at (in between it stays as it is).

signal turned(night: bool)

@export_range(0.0, 1.0) var darkness := 0.0
@export var turn_at := 0.6
@export var dawn_at := 0.35
@export var day_idle := "Day_Idle"
@export var turn_clip := "Turn"
@export var night_idle := "Idle"


var is_night := false
var _turning := false
@onready var day: Node3D = $Day
@onready var night: Node3D = $Night

func _ready() -> void:
	_play(day, day_idle)
	_play(night, night_idle)
	_show(day, night)


func _physics_process(_delta: float) -> void:
	if _turning:
		return
	if not is_night and darkness >= turn_at:
		_turn()
	elif is_night and darkness <= dawn_at:
		_back()


func _turn() -> void:
	_turning = true
	var ap := _anim(day)
	if ap and ap.has_animation(turn_clip):
		ap.play(turn_clip, 0.2)
		await ap.animation_finished          # Turn's last frame: the night's first Idle pose
	night.global_transform = day.global_transform
	_play(night, night_idle)
	_anim(night).seek(0.0, true)
	_show(night, day)
	is_night = true
	_turning = false
	turned.emit(true)


func _back() -> void:
	day.global_transform = night.global_transform
	_play(day, day_idle)
	_show(day, night)
	is_night = false
	turned.emit(false)

func _show(on: Node3D, off: Node3D) -> void:
	off.visible = false
	off.process_mode = Node.PROCESS_MODE_DISABLED
	on.visible = true
	on.process_mode = Node.PROCESS_MODE_INHERIT


func _play(body: Node3D, clip: String) -> void:
	var ap := _anim(body)
	if ap and ap.has_animation(clip):
		ap.play(clip)


func _anim(body: Node3D) -> AnimationPlayer:
	return body.find_child("AnimationPlayer", true, false) as AnimationPlayer
