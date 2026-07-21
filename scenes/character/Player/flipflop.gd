extends Area2D

@export var aoe_scene: PackedScene

var direction: Vector2
var damage: float = 25
var speed: float = 100.0

func _physics_process(delta) -> void:
	global_position += direction * speed * delta
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		area_damage()
		queue_free()
				
# refers to aoe_range scene
func area_damage() -> void:
	var aoe_hitbox = aoe_scene.instantiate()
	get_tree().current_scene.call_deferred("add_child", aoe_hitbox)
	
	aoe_hitbox.global_position = global_position
