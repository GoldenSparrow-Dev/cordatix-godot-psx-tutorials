extends RefCounted
## How to Draw Anomalies Without Repeats in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/liminal-psx-parking-anomalies/devlog/1731759/how-to-draw-anomalies-without-repeats-in-godot-4-liminal-psx-parking-anomalies
## An anomaly game's draw: each level is clean or has one anomaly. No anomaly comes twice before every one has come
## once (a bag that refills only when it is empty, never with the one just shown), each is picked by its weight, and
## a ramp makes the obvious ones likelier early in a run and the subtle ones deeper down. The run's first level is
## always clean, so the player learns the level before anything changes on it.
## `anomalies` holds anything with an `id`, a `tier` ("S" subtle, "N" noticeable, "O" obvious) and a `weight`: your
## anomaly nodes, or the Anomaly class below.

class Anomaly:
	var id := ""
	var tier := "N"
	var weight := 1.0

	func _init(p_id: String, p_tier := "N", p_weight := 1.0) -> void:
		id = p_id
		tier = p_tier
		weight = p_weight


var anomalies: Array = []
## The chance a level after the first is clean.
var clean_chance := 0.3
## The run goes from start_level down to goal_level (the way out).
var start_level := 6
var goal_level := 0
var rng := RandomNumberGenerator.new()

var _bag := {}                        # the ids drawn since the bag was last full
var _first := true
var _last = null                      # the anomaly drawn last


## A new run. The bag carries on, so a replay meets the anomalies the last run did not show first.
func start_run() -> void:
	_first = true


## The anomaly for this level, or null for a clean level.
func draw(level: int):
	if _first:
		_first = false
		return null
	if rng.randf() < clean_chance:
		return null
	var cands := []
	for a in anomalies:
		if a.weight > 0.0 and not _bag.has(a.id):
			cands.append(a)
	if cands.is_empty():
		_bag.clear()                  # every one has come: refill the bag, but not with the one just shown
		for a in anomalies:
			if a.weight > 0.0 and a != _last:
				cands.append(a)
	if cands.is_empty():
		return null
	# a weighted pick: each candidate takes its share of the line, weight times its tier's ramp here
	var weights: Array[float] = []
	var total := 0.0
	for a in cands:
		var w: float = a.weight * ramp(a.tier, level)
		weights.append(w)
		total += w
	var r := rng.randf() * total
	var pick = cands[cands.size() - 1]
	for i in cands.size():
		r -= weights[i]
		if r <= 0.0:
			pick = cands[i]
			break
	_bag[pick.id] = true
	_last = pick
	return pick


## A tier's weight on this level, on a ramp from the start level to the last level before the way out: an obvious
## anomaly from 2 down to 0.5, a subtle one from 0.15 up to 1.5, a noticeable one 1 all the way.
func ramp(tier: String, level: int) -> float:
	var t := clampf(float(start_level - level) / maxf(1.0, float(start_level - goal_level - 1)), 0.0, 1.0)
	match tier:
		"O":
			return lerpf(2.0, 0.5, t)
		"S":
			return lerpf(0.15, 1.5, t)
	return 1.0
