extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var health: float

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation_player.play("pick_up")
		body.update_health(health)
	
		# We summon queue_free through animation_player
		#await animation_player.animation_finished
		#queue_free()
