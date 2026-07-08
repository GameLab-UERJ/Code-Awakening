extends Node

enum TYPE_TRANSFORM {HUMAN,ROBOT}

@export var energy: float = 100.0
@export var energy_limit: float = 100.0
@export var energy_drain_rate: float = 20.0

signal emit_energy_update(new_energy: float)
signal form_changed(new_form: TYPE_TRANSFORM)

var current_form: TYPE_TRANSFORM = TYPE_TRANSFORM.HUMAN

@onready var timer: Timer = $Timer

@onready var player = get_parent()

func _ready() -> void:
	add_to_group("Transformer")

	timer.wait_time = 0.1 # bar goes slower
	timer.one_shot = false

	emit_energy_update.emit(energy)

# player requested
func change_form(new_form: TYPE_TRANSFORM) -> void:
	if player.current_scene.name == "lab_inicial":
		return
	
	# avoids transforming while no energy
	if new_form == TYPE_TRANSFORM.ROBOT and energy <= 0:
		return
	
	current_form = new_form
	
	if current_form == TYPE_TRANSFORM.ROBOT:
		player.human_animated_sprite.visible = false
		player.animated_sprite = player.robot_animated_sprite
		player.attack_basic *= 1.5 # cumulative; intentional
		timer.start()
	
	elif current_form == TYPE_TRANSFORM.HUMAN:
		player.robot_animated_sprite.visible = false
		player.animated_sprite = player.human_animated_sprite
		timer.stop()
		
	player.animated_sprite.visible = true	
	form_changed.emit(current_form) # talks to the player

func update_energy(added_energy: float) -> void:
	energy += added_energy
	energy = clamp(energy, 0.0, energy_limit)

	emit_energy_update.emit(energy)

func _on_timer_timeout() -> void:
	if current_form != TYPE_TRANSFORM.ROBOT:
		return

	# energy per second
	energy -= energy_drain_rate * timer.wait_time
	energy = max(energy, 0)
	emit_energy_update.emit(energy)

	if energy <= 0:
		change_form(TYPE_TRANSFORM.HUMAN)
