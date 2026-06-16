extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("Player")

# player will listen for changes on gem count
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.change_charge(true)
		animation_player.play("pick_up")
		
		await animation_player.animation_finished
		queue_free()
