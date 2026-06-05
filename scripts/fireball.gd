extends Area2D

var direction: Vector2 = Vector2.ZERO

# TBD
var speed: float = 0 
var damage: float = 0

func _physics_process(delta) -> void:
	position += direction * speed * delta
	
# mob has taken damage
func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.update_health(damage)
		queue_free()
