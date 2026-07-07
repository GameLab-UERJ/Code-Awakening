# BUG: Barra fica vazia antes da transformação 
# Energia não zera após fim do timer

extends Node

enum TYPE_TRANSFORM{HUMAN,ROBOT}

@export var energy: float = 100.0
@export var energy_limit: float

signal emit_energy_update(new_energy: float)

signal form_changed(new_form: TYPE_TRANSFORM) 
var current_form: TYPE_TRANSFORM

@onready var timer = $Timer
@export var time: float = 5.0 # debugging only, will be higher

@onready var player = get_parent()

func _ready() -> void:
	add_to_group("Transformer")
	
	energy_limit = energy
	
# player requested 
func change_form(new_form: TYPE_TRANSFORM) -> void:
	if player.current_scene.name == "lab_inicial":
		return
	
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
		
func handle_energy() -> void:
	if current_form != TYPE_TRANSFORM.ROBOT:
		return
	
	energy = timer.time_left / time 
	energy *= energy_limit

	emit_energy_update.emit(energy)
	
func update_energy(added_energy: float) -> void:
	timer.start(timer.time_left + added_energy)

func robot_timer():
	timer.start(time)
		
func _on_timer_timeout() -> void:
	timer.stop()
	
	change_form(TYPE_TRANSFORM.HUMAN)
	
func _process(delta) -> void:
	handle_energy()
	
