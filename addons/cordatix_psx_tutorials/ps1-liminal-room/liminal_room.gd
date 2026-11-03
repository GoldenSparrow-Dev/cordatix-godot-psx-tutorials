extends Node3D
## How to Build a PS1-Style Liminal Room in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/liminal-psx-textures/devlog/1710627/how-to-build-a-ps1-style-liminal-room-in-godot-4-liminal-psx-textures


func liminal_material(path: String, size_m: Vector2 = Vector2(2.0, 2.0)) -> StandardMaterial3D:
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = load(path)
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
	mat.roughness = 1.0
	# every texture covers 2 x 2 m, so a 6 x 3 m wall repeats it 3 x 1.5 times
	mat.uv1_scale = Vector3(size_m.x / 2.0, size_m.y / 2.0, 1.0)
	return mat


func blockout_material(path: String) -> StandardMaterial3D:
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = load(path)
	mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
	# world-space projection: one repeat every 2 m, whatever the size of the box
	mat.uv1_triplanar = true
	mat.uv1_world_triplanar = true
	mat.uv1_scale = Vector3(0.5, 0.5, 0.5)
	return mat


func ceiling_lamp(pos: Vector3) -> OmniLight3D:
	var lamp := OmniLight3D.new()
	lamp.position = pos
	lamp.light_color = Color(1.0, 0.95, 0.8)
	lamp.light_energy = 1.1
	lamp.omni_range = 6.0
	add_child(lamp)
	return lamp


func psx_viewport(world: Node3D, shrink: int = 3) -> SubViewportContainer:
	var container := SubViewportContainer.new()
	container.stretch = true
	container.stretch_shrink = shrink
	container.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	container.set_anchors_preset(Control.PRESET_FULL_RECT)
	var vp := SubViewport.new()
	container.add_child(vp)
	vp.add_child(world)
	return container
