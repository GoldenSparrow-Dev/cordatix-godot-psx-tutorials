extends Node
## How to Light Up the House the Player Just Left in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/cordatix-psx-horror-village/devlog/1744212/how-to-light-up-the-house-the-player-just-left-in-godot-4-cordatix-psx-horror-village
## Light up the house the player just left (Godot 4.3+). Walk out of a house and, behind your back, its windows glow
## and a lamp burns inside; come near it again and it goes dark before you reach its door. Each house is a Node3D child
## of this node; its windows are the MeshInstance3D nodes under it in the group "window" (their glass is the surface
## whose name has "glass" in it, an inside face's "..._in" aside, or their first); its inside is its meshes' footprint,
## `wall` metres in, at any height. The player is the body in the group "player".

## The glowing glass a lit house's windows show.
@export var lit_glass: Material
## Seconds after you are out before the house lights up, and how far out you must be.
@export var delay := 2.0
@export var leave_distance := 6.0
## How near a lit house you come before it goes dark.
@export var approach_distance := 5.0
## Houses lit at once at most: the one lit longest goes dark first.
@export var max_lit := 2
@export var wall := 0.3
@export var light_color := Color(1.0, 0.72, 0.42)
@export var light_energy := 1.6


var _inside: Node3D = null
var _left := {}          # house -> seconds since the player walked out of it
var _lit: Array = []
var _boxes := {}


func _physics_process(delta: float) -> void:
	var player := get_tree().get_first_node_in_group("player") as Node3D
	if player == null:
		return
	var at := player.global_position
	var now: Node3D = null
	for house in get_children():
		if house is Node3D and _inside_of(house, at):
			now = house
	if now != _inside:
		if _inside != null:
			_left[_inside] = 0.0
		_left.erase(now)
		_inside = now
	for house in _left.keys():
		_left[house] += delta
		if _left[house] >= delay and _distance(house, at) > leave_distance:
			_left.erase(house)
			light(house)
	for house in _lit.duplicate():
		if house != _inside and _distance(house, at) < approach_distance:
			darken(house)


## Whether a point is in a house: within its footprint, at any height (a player's origin is at their feet, on the
## floor, below the bounds' bottom brought in).
func _inside_of(house: Node3D, at: Vector3) -> bool:
	var b := _box(house)
	var p := house.to_local(at)
	return p.x > b.position.x and p.x < b.end.x and p.z > b.position.z and p.z < b.end.z


## A house's footprint, in its own space: the bounds of its meshes, `wall` metres in on every side.
func _box(house: Node3D) -> AABB:
	if not _boxes.has(house):
		var box := AABB()
		var first := true
		for mi in house.find_children("*", "MeshInstance3D", true, false):
			var b: AABB = house.global_transform.affine_inverse() * (mi as MeshInstance3D).global_transform \
				* (mi as MeshInstance3D).get_aabb()
			box = b if first else box.merge(b)
			first = false
		_boxes[house] = AABB(box.position + Vector3(wall, 0.0, wall), box.size - Vector3(2.0 * wall, 0.0, 2.0 * wall))
	return _boxes[house]


## How far a point is from a house, along the ground (0 inside).
func _distance(house: Node3D, at: Vector3) -> float:
	var b := _box(house)
	var p := house.to_local(at)
	var q := p.clamp(b.position, b.end)
	return Vector2(p.x - q.x, p.z - q.z).length()


func light(house: Node3D) -> void:
	if house in _lit:
		return
	_lit.append(house)
	if _lit.size() > max_lit:
		darken(_lit[0])
	for mi in _windows(house):
		mi.set_surface_override_material(_glass(mi), lit_glass)
	var lamp := OmniLight3D.new()
	lamp.name = "LeftLamp"
	lamp.light_color = light_color
	lamp.light_energy = light_energy
	lamp.position = _box(house).get_center()
	lamp.omni_range = _box(house).size.length() * 0.6
	house.add_child(lamp)


func darken(house: Node3D) -> void:
	if not house in _lit:
		return
	_lit.erase(house)
	for mi in _windows(house):
		mi.set_surface_override_material(_glass(mi), null)
	var lamp := house.get_node_or_null("LeftLamp")
	if lamp != null:
		house.remove_child(lamp)
		lamp.queue_free()


func is_lit(house: Node3D) -> bool:
	return house in _lit


func _windows(house: Node3D) -> Array:
	var out: Array = []
	for mi in house.find_children("*", "MeshInstance3D", true, false):
		if mi.is_in_group("window"):
			out.append(mi)
	return out


## The window's glass: the surface named "...glass..." (not an inside face's "..._in": that one stays dark), or its
## first.
func _glass(mi: MeshInstance3D) -> int:
	for i in mi.mesh.get_surface_count():
		if mi.mesh is ArrayMesh:
			var n := (mi.mesh as ArrayMesh).surface_get_name(i)
			if "glass" in n and not n.ends_with("_in"):
				return i
	return 0
