extends Node2D

@export var projectile_scene: PackedScene

# press x key
func shoot(direction: Vector2) -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	# where it went
	projectile.global_position = global_position
	projectile.direction = direction
