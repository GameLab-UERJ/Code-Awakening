extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var transformer = get_tree().get_first_node_in_group("Transformer")

# time in seconds that will be added to transformation
@export var added_energy: float = 1.0

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation_player.play("pick_up")
		transformer.update_energy(added_energy)
