extends Area2D

@export var damage: float = 20.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.update_health(-damage)
		
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 100, 0.5)
		
		queue_free()
		
