extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var transformer = get_tree().get_first_node_in_group("Transformer")

# energy that will be added to the transformation
@export var added_energy: float = 20.0

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animation_player.play("pick_up")
		transformer.update_energy(added_energy)
