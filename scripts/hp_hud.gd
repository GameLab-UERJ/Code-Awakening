extends Node2D

@onready var hp_bar = $CanvasLayer/hp_bar
@onready var energy_bar = $CanvasLayer/energy_bar
@onready var VictoryCounter: Label = $CanvasLayer/VictoryCounter
@onready var special_bar: Control = $CanvasLayer/CenterContainer/special_bar

var gems: Array = []

@onready var player: CharacterBody2D = $"../Player"

func _ready() -> void:
	player.emit_health_update.connect(_on_health_update)
	player.emit_energy_update.connect(_on_energy_update)

	# TODO: Work onto a event bus to avoid this mess	
	var fire_gem = get_tree().get_first_node_in_group("Fire Gem")
	fire_gem.emit_charge_update.connect(_on_charge_update)
	
	gems = special_bar.get_children()
	for gem in gems:
		gem.modulate.a = 0.4
	
func _on_health_update(new_health: float) -> void:
	hp_bar.value = new_health

func _on_energy_update(new_energy: float) -> void:
	energy_bar.value = new_energy

func _on_charge_update(amount: int) -> void:
	for i in range(gems.size()):
		if i < amount:
			gems[i].modulate.a = 1
		else:
			gems[i].modulate.a = 0.4

func _process(delta: float) -> void:
	VictoryCounter.text = "%d / 2" % Global.victories
