extends Area3D
## How to Lock the Player in a Boss Arena in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/cordatix-psx-horror-boss-arena/devlog/1741814/how-to-lock-the-player-in-a-boss-arena-in-godot-4-cordatix-psx-horror-boss-arena
## Lock the player in a boss arena (Godot 4.3+). Give this Area3D a CollisionShape3D over the arena's floor. When the
## player walks in, the gates slam down behind them (solid at once, so nobody slips under) and the boss starts; when
## the boss dies, the gates rise and stay open; when the player dies, the arena puts everything back as it was before
## the fight, the player outside the door, so walking in again is the same fight.

signal sealed
signal released
signal retried

## The gates: each a Node3D that drops by `gate_drop` metres to shut, its collision shapes anywhere under it.
@export var gates: Array[NodePath] = []
@export var gate_drop := 4.0
@export var slam_time := 0.3
@export var rise_time := 1.5
## The boss: any node with a `died` signal; start(player) and reset() are called if it has them.
@export var boss_path: NodePath
## Where the player comes back on a retry, and how long after the death.
@export var restart_path: NodePath
@export var retry_delay := 1.5
@export var player_group := "player"

var player: Node3D
var is_sealed := false
var is_cleared := false
var _retry_t := -1.0
var _shut := {}                  # gate: where it stands shut (as you placed it)
var _moving := {}                # gate: the tween moving it now


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	for p in gates:
		var g := get_node(p) as Node3D
		_shut[g] = g.position
		g.position.y += gate_drop          # authored shut: lift it out of the doorway
		_set_solid(g, false)
	var boss := get_node_or_null(boss_path)
	if boss != null:
		boss.died.connect(_on_boss_died)


func _on_body_entered(body: Node3D) -> void:
	if is_sealed or is_cleared or _retry_t >= 0.0 or not body.is_in_group(player_group):
		return
	player = body
	is_sealed = true
	for p in gates:
		var g := get_node(p) as Node3D
		_set_solid(g, true)                # solid now, before the gate is down
		_move(g, _shut[g].y, slam_time, Tween.TRANS_QUAD, Tween.EASE_IN)
	if player.has_signal("died") and not player.is_connected("died", _on_player_died):
		player.died.connect(_on_player_died)
	var boss := get_node_or_null(boss_path)
	if boss != null and boss.has_method("start"):
		boss.start(player)
	sealed.emit()


func _open_gates() -> void:
	for p in gates:
		var g := get_node(p) as Node3D
		var t := _move(g, _shut[g].y + gate_drop, rise_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		t.tween_callback(_set_solid.bind(g, false))  # the way is clear once it is up


func _move(g: Node3D, y: float, time: float, trans: Tween.TransitionType, easing: Tween.EaseType) -> Tween:
	if _moving.has(g):
		(_moving[g] as Tween).kill()       # a gate turned back half way: no old tween fights the new one
	var t := create_tween()
	t.tween_property(g, "position:y", y, time).set_trans(trans).set_ease(easing)
	_moving[g] = t
	return t


func _on_boss_died() -> void:
	if not is_sealed:
		return
	is_sealed = false
	is_cleared = true
	_open_gates()
	released.emit()


func _on_player_died() -> void:
	if is_sealed and _retry_t < 0.0:
		_retry_t = retry_delay


func _physics_process(delta: float) -> void:
	if _retry_t < 0.0:
		return
	_retry_t -= delta
	if _retry_t >= 0.0:
		return
	_retry_t = -1.0
	is_sealed = false
	_open_gates()
	var boss := get_node_or_null(boss_path)
	if boss != null and boss.has_method("reset"):
		boss.reset()
	var at := get_node_or_null(restart_path) as Node3D
	if at != null:
		player.global_transform = at.global_transform
	if player.has_method("revive"):
		player.revive()
	retried.emit()


func _set_solid(gate: Node, on: bool) -> void:
	for c in gate.find_children("*", "CollisionShape3D", true, false):
		(c as CollisionShape3D).set_deferred("disabled", not on)
