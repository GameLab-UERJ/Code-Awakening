extends Area2D

var direction: Vector2
var damage: float = 100.0
var speed: float = 100.0

func _physics_process(delta) -> void:
	global_position += direction * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.update_health(-damage)
		queue_free()
		
	
