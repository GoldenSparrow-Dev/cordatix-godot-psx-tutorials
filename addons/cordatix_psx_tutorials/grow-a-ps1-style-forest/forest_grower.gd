@tool
extends Node3D
## How to Grow a PS1-Style Forest in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/cordatix-psx-horror-forest/devlog/1743440/how-to-grow-a-ps1-style-forest-in-godot-4-cordatix-psx-horror-forest
## Grow a PS1-style forest (Godot 4.3+). Trees are scattered over an area by a seed (the same seed, the same forest),
## kept off the trails you draw as Path3D curves, set on the ground below them, and drawn as MultiMeshes in chunks:
## each tree as its model near, as its flat card far, nothing past the fog's end. Each trunk gets a cylinder, so the
## player walks round the trees. In the editor, tick `grow_now`; at runtime it grows by itself.

@export var size := Vector2(60.0, 60.0)
@export var seed := 1
@export var trees_per_100m2 := 2.5
## No two trunks closer than this.
@export var spacing := 2.4
## One entry per kind of tree: its model, its far card and how common it is.
@export var meshes: Array[Mesh] = []
@export var cards: Array[Mesh] = []
@export var weights: Array[float] = []
@export var trails: Array[NodePath] = []
## A trunk keeps this far from a trail's middle.
@export var trail_margin := 2.0
## Rays down find the ground (the physics bodies under the area); off, the trees stand on this node's plane.
@export var follow_ground := true
@export var chunk_size := 24.0
@export var far_distance := 45.0
@export var fade_end := 100.0
@export var trunk_radius := 0.25
@export var grow_now := false:
	set(v):
		grow_now = false
		if v and is_inside_tree():
			grow()


var _waiting := false


func _ready() -> void:
	if not Engine.is_editor_hint() and get_node_or_null("Chunks") == null:
		_waiting = true            # rays need the physics world: grow on the first physics frame


func _physics_process(_delta: float) -> void:
	if _waiting:
		_waiting = false
		grow()


func grow() -> void:
	var old := get_node_or_null("Chunks")
	if old != null:
		remove_child(old)
		old.free()
	var chunks := Node3D.new()
	chunks.name = "Chunks"
	add_child(chunks)
	var rng := RandomNumberGenerator.new()
	rng.seed = seed
	var total := 0.0
	for w in weights:
		total += w
	var cell := maxf(spacing, sqrt(100.0 / trees_per_100m2))
	var groups := {}                 # Vector3i(chunk x, chunk z, kind): [Transform3D]
	for i in int(size.x / cell):
		for j in int(size.y / cell):
			var x := -size.x / 2.0 + (i + rng.randf()) * cell
			var z := -size.y / 2.0 + (j + rng.randf()) * cell
			var pick := rng.randf() * total
			var kind := 0
			while kind < weights.size() - 1 and pick > weights[kind]:
				pick -= weights[kind]
				kind += 1
			var yaw := rng.randf() * TAU
			var s := rng.randf_range(0.85, 1.15)
			var y := _ground_y(Vector3(x, 0.0, z))
			if is_nan(y) or _near_trail(to_global(Vector3(x, y, z))):
				continue
			var key := Vector3i(floori(x / chunk_size), floori(z / chunk_size), kind)
			var list: Array = groups.get(key, [])
			list.append(Transform3D(Basis(Vector3.UP, yaw).scaled(Vector3(s, s, s)), Vector3(x, y, z)))
			groups[key] = list
	for key in groups:
		var middle := Vector3((key.x + 0.5) * chunk_size, 0.0, (key.y + 0.5) * chunk_size)
		var near := _multimesh(chunks, meshes[key.z], groups[key], middle)
		near.visibility_range_end = far_distance
		if key.z < cards.size() and cards[key.z] != null:
			var far := _multimesh(chunks, cards[key.z], groups[key], middle)
			far.visibility_range_begin = far_distance
			far.visibility_range_end = fade_end
		else:
			near.visibility_range_end = fade_end
		_trunks(chunks, groups[key])


## The ground's height under a local point: a ray down through the physics world (NAN where there is none).
func _ground_y(local: Vector3) -> float:
	if not follow_ground:
		return 0.0
	var top := to_global(local + Vector3(0.0, 50.0, 0.0))
	var q := PhysicsRayQueryParameters3D.create(top, top - Vector3(0.0, 100.0, 0.0))
	var hit := get_world_3d().direct_space_state.intersect_ray(q)
	return to_local(hit["position"]).y if not hit.is_empty() else NAN


func _near_trail(world: Vector3) -> bool:
	for p in trails:
		var path := get_node_or_null(p) as Path3D
		if path == null:
			continue
		var c := path.to_global(path.curve.get_closest_point(path.to_local(world)))
		if Vector2(c.x - world.x, c.z - world.z).length() < trail_margin:
			return true
	return false


func _multimesh(parent: Node, mesh: Mesh, xforms: Array, middle: Vector3) -> MultiMeshInstance3D:
	var mm := MultiMesh.new()
	mm.transform_format = MultiMesh.TRANSFORM_3D
	mm.mesh = mesh
	mm.instance_count = xforms.size()
	for i in xforms.size():
		mm.set_instance_transform(i, xforms[i].translated(-middle))
	var mmi := MultiMeshInstance3D.new()
	mmi.multimesh = mm
	mmi.position = middle            # the camera's distance is measured to the chunk's middle
	parent.add_child(mmi)
	return mmi


func _trunks(parent: Node, xforms: Array) -> void:
	var body := StaticBody3D.new()
	parent.add_child(body)
	for t in xforms:
		var shape := CylinderShape3D.new()
		shape.radius = trunk_radius
		shape.height = 3.0
		var cs := CollisionShape3D.new()
		cs.shape = shape
		cs.position = t.origin + Vector3(0.0, 1.5, 0.0)
		body.add_child(cs)
