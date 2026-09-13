class_name DropItem extends Node2D

@export var item_drop: Array[PackedScene]
@export var item_drop_chances: Array[float]

var weight: float
var total_weight: float

var rand: float
var update_drop_value: float

var item: Node2D

@onready var tilemap = get_tree().get_first_node_in_group("Ground")

func _fix_item_drop_arrays() -> void:
	if item_drop_chances.size() < item_drop.size():
		item_drop_chances.resize(item_drop.size())
	elif item_drop.size() < item_drop_chances.size():
		item_drop.resize(item_drop_chances.size())

	for i in item_drop_chances:
		if i <= 0.0:
			i = 0.1

func is_spawn_allowed(global_pos: Vector2) -> bool:
	if not tilemap:
		return false 
		
	# the item needs a place to drop	
	var local_pos = tilemap.to_local(global_pos)
	var tile_pos = tilemap.local_to_map(local_pos)
	var tile_data = tilemap.get_cell_tile_data(tile_pos)
	
	if tile_data == null:
		return false 
		
	return tile_data.get_custom_data("spawn_allowed")

func def_spawn_position() -> Vector2:
	var test_pos: Vector2 = global_position
	
	for i in range(10): # number of attempts for spawning
		var offset: Vector2 = Vector2(randf_range(-32, 32), randf_range(-32, 32))
		
		test_pos = global_position + offset
		if is_spawn_allowed(test_pos):
			return test_pos
			
	return Vector2.ZERO		

func _drop_item() -> void:
	total_weight = 0.0
	
	for w in item_drop_chances:
		total_weight += w
		
	rand = randf_range(0.0, total_weight)
	
	update_drop_value = 0.0
	
	for i in item_drop_chances.size():
		update_drop_value += item_drop_chances[i]
		
		if rand <= update_drop_value:
			if item_drop[i] == null:
				return
				
			item = item_drop[i].instantiate()
			
			# the item needs a legal area to spawn			
			item.global_position = def_spawn_position()
			
			get_tree().current_scene.call_deferred("add_child", item)
						
			break
			
func drop_specific(id: int) -> void:
	var new_item = item_drop[id].instantiate()
	new_item.global_position = def_spawn_position()
	get_tree().current_scene.add_child(new_item)
