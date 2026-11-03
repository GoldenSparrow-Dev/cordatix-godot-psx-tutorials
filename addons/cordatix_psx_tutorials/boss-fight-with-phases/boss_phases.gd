extends Node
## How to Make a Boss Fight with Phases in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/cordatix-psx-horror-bosses/devlog/1739569/how-to-make-a-boss-fight-with-phases-in-godot-4-cordatix-psx-horror-bosses
## A boss's phases (Godot 4.3+): its health, the phase it is in (each begins when the health falls to its share of
## the maximum), a transition clip it cannot be hurt during, and each phase's attacks drawn by weight, never the same
## one three times running. Add it to the boss as a child, point it at the boss's AnimationPlayer, call hit() from
## your weapon, and connect its signals for the rest (a health bar, a sound, the arena's doors).

signal phase_changed(index: int)
signal attack_started(clip: String)
signal defeated

@export var anim_path: NodePath
@export var max_health := 600.0
## Each phase: "below", the share of the maximum health it begins at (1.0 for the first); "transition", the clip it
## plays as it begins ("" for none); "idle", its clip between attacks; "attacks", its attack clips and their weights.
@export var phases: Array[Dictionary] = [
	{"below": 1.0, "transition": "", "idle": "Idle", "attacks": {"Attack": 2.0, "Attack2": 1.0}},
	{"below": 0.5, "transition": "Scream", "idle": "Idle", "attacks": {"Attack": 1.0, "Attack2": 2.0}},
]
## Seconds between two attacks, drawn between these two.
@export var pause_min := 0.6
@export var pause_max := 1.4
@export var death_clip := "Death"

var health := 0.0
var phase := 0
var history: Array[String] = []          # the attacks drawn, in order

var _anim: AnimationPlayer
var _busy := 0.0                          # seconds the clip it plays now still runs
var _wait := 1.0
var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	_anim = get_node(anim_path) as AnimationPlayer
	health = max_health
	_anim.play(phases[0]["idle"])


## Damage to the boss. False when it did not count: during a transition, or once it is dead.
func hit(amount: float) -> bool:
	if health <= 0.0 or _in_transition():
		return false
	health = maxf(health - amount, 0.0)
	if health == 0.0:
		_play(death_clip)
		defeated.emit()
		return true
	var next := phase
	for i in phases.size():
		if health / max_health <= float(phases[i]["below"]):
			next = i
	if next > phase:
		phase = next
		_play(String(phases[phase]["transition"]))
		phase_changed.emit(phase)
	return true


func _physics_process(delta: float) -> void:
	if health <= 0.0:
		return
	if _busy > 0.0:
		_busy -= delta
		if _busy <= 0.0:
			_anim.play(phases[phase]["idle"])
		return
	_wait -= delta
	if _wait <= 0.0:
		var clip := _draw()
		_play(clip)
		history.append(clip)
		attack_started.emit(clip)
		_wait = _rng.randf_range(pause_min, pause_max)


## One of the phase's attacks by weight, leaving out one drawn the last two times.
func _draw() -> String:
	var pool: Dictionary = phases[phase]["attacks"]
	var ok: Array[String] = []
	var total := 0.0
	for clip in pool:
		var twice: bool = history.size() >= 2 and history[-1] == clip and history[-2] == clip
		if not twice or pool.size() == 1:
			ok.append(clip)
			total += float(pool[clip])
	var r := _rng.randf() * total
	for clip in ok:
		r -= float(pool[clip])
		if r <= 0.0:
			return clip
	return ok[-1]


func _play(clip: String) -> void:
	if clip == "" or not _anim.has_animation(clip):
		return
	_anim.play(clip)
	_busy = _anim.get_animation(clip).length


func _in_transition() -> bool:
	var t := String(phases[phase]["transition"])
	return t != "" and _busy > 0.0 and _anim.current_animation == t
