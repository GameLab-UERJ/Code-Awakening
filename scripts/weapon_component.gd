extends Node

@export var projectile_scene: PackedScene

func _shoot(direction: Vector2) -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	projectile.global_position = owner.global_position
	projectile.direction = direction
		
