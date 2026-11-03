# Sets what the Cordatix packs' 3D levels ask of the project it runs in, and saves project.godot: the Compatibility
# renderer's light limits, decals and light projectors filtered nearest, the navigation map's cells. Run it once from
# your project's folder, with the project closed in the editor (an open editor can save its own copy over it):
#   godot --headless --path . -s res://cordatix_project_setup.gd
# A light limit already higher stays as it is; a second run changes nothing.
extends SceneTree
## How to Use Several PSX Asset Packs in One Godot 4 Project
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/cordatix-psx-mega-pack/devlog/1738246/how-to-use-several-psx-asset-packs-in-one-godot-4-project-cordatix-psx-mega-pack

# at least these: the Compatibility renderer's light limits (an anomaly kit's floor lights a mesh with up to 32 lights)
const AT_LEAST := {
	"rendering/limits/opengl/max_renderable_lights": 64,
	"rendering/limits/opengl/max_lights_per_object": 32,
}
# exactly these: decals and light projectors filtered nearest, as the PS1 look draws every texture; the navigation
# map's cells as small as the monsters' navigation meshes (0.1 m)
const EXACTLY := {
	"rendering/textures/decals/filter": 0,
	"rendering/textures/light_projectors/filter": 0,
	"navigation/3d/default_cell_size": 0.1,
	"navigation/3d/default_cell_height": 0.1,
}


func _init() -> void:
	var changed: Array[String] = []
	for key in AT_LEAST:
		if int(ProjectSettings.get_setting(key, 0)) < AT_LEAST[key]:
			ProjectSettings.set_setting(key, AT_LEAST[key])
			changed.append(key)
	for key in EXACTLY:
		if ProjectSettings.get_setting(key) != EXACTLY[key]:
			ProjectSettings.set_setting(key, EXACTLY[key])
			changed.append(key)
	if changed.is_empty():
		print("Cordatix: the project settings are already set.")
	else:
		var err := ProjectSettings.save()
		print("Cordatix: set %s; %s." % [", ".join(changed), "saved" if err == OK else "not saved (error %d)" % err])
	quit()
