# TODO: Realizar atualização de energia a partir deste node
# Iniciar e encerrar transformação com signals?
# Integração com hp_hud para demonstrar consumo de energia
extends Node

enum TYPE_TRANSFORM{HUMAN,ROBOT}

signal form_changed(new_form: TYPE_TRANSFORM) 
var current_form: TYPE_TRANSFORM

@onready var player = get_parent()

# player requested 
func change_form(new_form: TYPE_TRANSFORM) -> void:
	current_form = new_form
	
	if current_form == TYPE_TRANSFORM.ROBOT:
		player.human_animated_sprite.visible = false
		player.animated_sprite = player.robot_animated_sprite
		player.attack_basic *= 1.5 # cumulative; intentional
		robot_timer()
	
	elif current_form == TYPE_TRANSFORM.HUMAN:
		player.robot_animated_sprite.visible = false
		player.animated_sprite = player.human_animated_sprite
		
	player.animated_sprite.visible = true	
	form_changed.emit(current_form) # talks to the player
		

func robot_timer():
	var time = 5 # debugging only, will be higher
	player.transformation_timer.start(time)
		
func _on_transformation_timer_timeout() -> void:
	player.transformation_timer.stop()
	change_form(TYPE_TRANSFORM.HUMAN)
	
	player.update_energy()
