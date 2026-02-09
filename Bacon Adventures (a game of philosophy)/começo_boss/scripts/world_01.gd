extends Node2D
@onready var player: CharacterBody2D = $"player"
@onready var camera := $camera as Camera2D
@onready var player_scene := preload("res://players/actors.tscn")
@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	Globals.player = player
	Globals.player.follow_camera(camera)
	player.player_has_died.connect(game_over)	
	Globals.coins = 0 
	Globals.score = 0 
	Globals.player_life = 3

func reload_game():
	await get_tree().create_timer(10.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.player_has_died.connect(game_over)
	Globals.respanw_player()  # <-- AQUI agora
	Globals.coins = 0 
	Globals.score = 0 
	Globals.player_life = 3


func game_over():
	get_tree().change_scene_to_file("res://game_over.tscn")



func _on_talk_pressed() -> void:
	print("Botão clicado")
	get_tree().change_scene_to_file("res://aristoteles_talk.tscn")
