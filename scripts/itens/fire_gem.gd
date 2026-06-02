extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal emit_charge_update(new_charge: int) 
var gem_value: int = 1

func _ready() -> void:
	add_to_group("Fire Gem")
	
	var player = get_tree().get_first_node_in_group("Player")
	
	if player:
		emit_charge_update.connect(player._on_token_collected)

# player will listen for changes on gem count
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		emit_charge_update.emit(gem_value)
		animation_player.play("pick_up")
		
