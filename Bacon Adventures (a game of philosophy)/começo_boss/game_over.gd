extends Control



func _ready():
	Globals.coins = 0 
	Globals.score = 0 
	Globals.player_life = 3
	

func _on_restart_buttom_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/mundo_02.tscn")


func _on_quit_buttom_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
	
