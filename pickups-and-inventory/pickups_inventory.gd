extends CharacterBody3D
## How to Make Pickups With Inventory Icons in Godot 4
## Cordatix Godot 4 PSX tutorials, MIT licensed: https://github.com/GoldenSparrow-Dev/cordatix-godot-psx-tutorials
## The devlog: https://cordatix.itch.io/haunted-psx-props/devlog/1719493/how-to-make-pickups-with-inventory-icons-in-godot-4-haunted-psx-props

signal inventory_changed

const REACH := 2.2

var inventory: Array = []
@onready var camera: Camera3D = $Camera3D


## The two methods every Haunted PSX pickup and locked scene asks a player for.
func add_item(id: String, item_name: String, icon: Texture2D) -> void:
	inventory.append({"id": id, "name": item_name, "icon": icon})
	inventory_changed.emit()


func has_item(id: String) -> bool:
	for it in inventory:
		if it["id"] == id:
			return true
	return false


func _ready() -> void:
	inventory_changed.connect(fill_bar.bind($Hud/Bar))    # redraw the bar whenever the list changes


## What the player looks at: a ray from the eye that also meets the pickups' Area3D.
func look_target() -> Node:
	var from := camera.global_position
	var q := PhysicsRayQueryParameters3D.create(from, from - camera.global_transform.basis.z * REACH)
	q.collide_with_areas = true
	q.exclude = [get_rid()]
	var hit := get_world_3d().direct_space_state.intersect_ray(q)
	var n: Node = hit.get("collider") if hit else null
	while n != null and not n.has_method("interact"):
		var pk := n.get_node_or_null("Pickup")
		if pk != null:
			return pk
		n = n.get_parent()
	return n


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var t := look_target()
		if t != null:
			t.interact(self)


## An inventory bar: one TextureRect per item, nearest filtering so the PS1 icons stay crisp.
func fill_bar(bar: HBoxContainer) -> void:
	for c in bar.get_children():
		c.queue_free()
	for it in inventory:
		var t := TextureRect.new()
		t.texture = it["icon"]
		t.custom_minimum_size = Vector2(64, 64)
		t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		t.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		bar.add_child(t)
