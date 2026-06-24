extends Node

@export var flipflop_scene: PackedScene
@export var fireball_scene: PackedScene

func shoot_flipflop(direction: Vector2):
	_spawn_projectile(flipflop_scene, direction)
	
func shoot_fireball(direction: Vector2):
	_spawn_projectile(fireball_scene, direction)

func _spawn_projectile(scene: PackedScene, direction: Vector2) -> void:
	var projectile = scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	projectile.global_position = owner.global_position
	projectile.direction = direction 
