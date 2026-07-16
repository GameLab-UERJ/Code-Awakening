extends Node2D

var current_scene: String = "world"

@onready var player: CharacterBody2D = $Environment/Player
@onready var transformer = get_tree().get_first_node_in_group("Transformer")
@onready var hp_hud: Node2D = $Environment/hp_hud

@onready var block_cave_plaines: TileMapLayer = $Environment/Caves/CavePlaines/BlockCavePlaines
@onready var block_cave_montain: TileMapLayer = $Environment/Caves/CaveMontain/BlockCaveMontain


func _ready() -> void:
	if Global.block_cave_plaines:
		player.position = Global.last_world_positioin + Vector2(0, 24)
	elif Global.block_cave_montains:
		player.position = Global.last_world_positioin + Vector2(0, 24)
	elif Global.last_world_positioin != Vector2.ZERO:
		player.position = Global.last_world_positioin + Vector2(0, 2)
	
		hp_hud._on_health_update(Global.health)
		player.health = Global.health
		
		hp_hud._on_energy_update(Global.energy)
		transformer.energy = Global.energy
	
	if Global.block_cave_plaines:
		block_cave_plaines.enabled = true
		print("plaines conquered")
		
		if not Global.plaines_counted:
			Global.victories += 1
			Global.plaines_counted = true
	
	if Global.block_cave_montains:
		block_cave_montain.enabled = true
		print("montain conquered")
		
		if not Global.montains_counted:
			Global.victories += 1
			Global.montains_counted = true
		

func _process(delta: float) -> void:
	if Global.block_cave_montains and Global.block_cave_plaines:
		TransitionScene.change_scene("res://scenes/ui/endgame_screen.tscn")


func _on_cave_montain_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		change_scene("montain")


func _on_cave_plaines_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):	
		change_scene("plaines")


func change_scene(change_to: String) -> void:
	Global.last_world_positioin = player.position
	
	Global.health = player.health
	
	Global.energy = transformer.energy
	
	match change_to:
		"montain":
			TransitionScene.change_scene("res://scenes/cave_montain.tscn")
		"plaines":
			TransitionScene.change_scene("res://scenes/cave_plaines.tscn")
