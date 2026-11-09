extends CharacterBody3D
## How to Make a Monster Hide Until a Flashlight Finds It in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/haunted-psx-monsters/devlog/1764265/how-to-make-a-monster-that-hides-until-your-flashlight-finds-it-in-godot-4-cordatix-psx-horror-monsters

## Dim in the dark; where a flashlight's beam falls on it, it pales and glows a little, and it fades back when the
## beam moves on. Any SpotLight3D in the group "flashlight" counts.
@export var dark := 0.5              # its colours in the dark, times this
@export var glow := 0.35             # how much it glows in the beam
@export var fade_in := 0.12          # seconds to show when the beam finds it
@export var fade_out := 0.6          # seconds to fade back when the beam leaves
@export var heights: Array[float] = [0.6, 1.1, 1.6]   # where on the body the beam can find it, metres up

var reveal := 0.0                    # 0 in the dark, 1 in the beam
var _mats: Array[StandardMaterial3D] = []
var _colours: Array[Color] = []
var _own_glow: Array[bool] = []


func _ready() -> void:
	# its own copy of each material: revealing it must not light every monster that shares the texture
	for node in find_children("*", "MeshInstance3D", true, false):
		var mi := node as MeshInstance3D
		if mi.mesh == null:
			continue
		for i in mi.mesh.get_surface_count():
			var mat := mi.get_active_material(i) as StandardMaterial3D
			if mat == null:
				continue
			mat = mat.duplicate()
			var own := mat.emission_enabled      # a glow map of its own (eyes, flames) stays: it glows in the dark too
			if not own:
				mat.emission_enabled = true
				mat.emission = Color.WHITE
				mat.emission_texture = mat.albedo_texture
				mat.emission_operator = BaseMaterial3D.EMISSION_OP_MULTIPLY
			mi.set_surface_override_material(i, mat)
			_mats.append(mat)
			_colours.append(mat.albedo_color)
			_own_glow.append(own)
	_apply()


## Whether a flashlight's beam falls on a point: the light on, the point within its range and inside its cone, and
## nothing in between (the ray skips this body and the body that carries the light).
func in_beam(light: SpotLight3D, point: Vector3) -> bool:
	if not light.is_visible_in_tree():
		return false
	var from := light.global_position
	var to := point - from
	if to.length() > light.spot_range:
		return false
	var forward := -light.global_transform.basis.z          # a light shines down its -Z
	if rad_to_deg(forward.angle_to(to)) > light.spot_angle:  # spot_angle is half the cone
		return false
	var skip: Array[RID] = [get_rid()]
	var holder: Node = light.get_parent()
	while holder != null and not holder is CollisionObject3D:
		holder = holder.get_parent()
	if holder != null:
		skip.append((holder as CollisionObject3D).get_rid())
	var ray := PhysicsRayQueryParameters3D.create(from, point)
	ray.exclude = skip
	return get_world_3d().direct_space_state.intersect_ray(ray).is_empty()


## Every physics frame: lit when any flashlight finds any of its points, then it eases to lit or to dark.
func _physics_process(delta: float) -> void:
	var lit := false
	for light in get_tree().get_nodes_in_group("flashlight"):
		for h in heights:
			if light is SpotLight3D and in_beam(light, global_position + Vector3.UP * h):
				lit = true
	reveal = move_toward(reveal, 1.0 if lit else 0.0, delta / (fade_in if lit else fade_out))
	_apply()


func _apply() -> void:
	var shade := lerpf(dark, 1.0, reveal)
	for i in _mats.size():
		var c := _colours[i]
		_mats[i].albedo_color = Color(c.r * shade, c.g * shade, c.b * shade, c.a)
		if not _own_glow[i]:
			_mats[i].emission_energy_multiplier = glow * reveal
