extends SkeletonModifier3D
## How to Make NPCs Turn Their Heads to the Player in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/psx-bystanders-npc-pack/devlog/1737124/how-to-make-npcs-turn-their-heads-to-the-player-in-godot-4-psx-bystanders-npc-pack
## Turns a person's chest, neck and head to the camera when it comes near in front of them, over whatever clip plays:
## the turn shared by the bones (the chest a little, the head most), held within max_yaw, at most turn_speed degrees a
## second, and back to the clip's own pose when the camera goes away or behind them. Add it as a child of the
## person's Skeleton3D (Godot 4.3 or newer). The head bone's +Z is where the face points.

## The bones that share the turn, and their shares (they add up to 1).
@export var bones: Array = [["Chest", 0.15], ["Neck", 0.35], ["Head", 0.5]]
## Degrees to each side, at most.
@export var max_yaw := 65.0
## Degrees a second, at most.
@export var turn_speed := 30.0
## How near the camera must come (metres, across the floor).
@export var distance := 4.0

## The turn now, in degrees (left of the face positive).
var yaw := 0.0
var _ids: Array = []


func _process_modification() -> void:
	var sk := get_skeleton()
	if sk == null:
		return
	if _ids.is_empty():
		for b in bones:
			var i := sk.find_bone(String(b[0]))
			if i >= 0:
				_ids.append([i, float(b[1])])
		if _ids.is_empty():
			return
	var want := 0.0
	var cam := get_viewport().get_camera_3d()
	if cam:
		# where the camera is, against where the face points in the clip alone, across the floor
		var head: Transform3D = sk.global_transform * sk.get_bone_global_pose(_ids[-1][0])
		var face := head.basis.z
		var to := cam.global_position - head.origin
		var angle := rad_to_deg(atan2(face.z * to.x - face.x * to.z, face.x * to.x + face.z * to.z))
		if Vector2(to.x, to.z).length() < distance and absf(angle) < 100.0:      # near, and not behind
			want = clampf(angle, -max_yaw, max_yaw)
	yaw = move_toward(yaw, want, turn_speed * get_process_delta_time())


	# each bone turns its share about the vertical through its joint, in its parent's space
	var up := (sk.global_transform.basis.inverse() * Vector3.UP).normalized()
	for e in _ids:
		var i: int = e[0]
		var parent := sk.get_bone_parent(i)
		var axis := up if parent < 0 else (sk.get_bone_global_pose(parent).basis.inverse() * up).normalized()
		sk.set_bone_pose_rotation(i, Quaternion(axis, deg_to_rad(yaw * float(e[1]))) * sk.get_bone_pose_rotation(i))
