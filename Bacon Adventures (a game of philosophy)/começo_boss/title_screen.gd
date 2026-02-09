extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_buttom_pressed() -> void:
	get_tree().change_scene_to_file("res://transition_world_1.tscn")


func _on_start_buttom_2_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/credits.tscn")

func _on_start_buttom_4_pressed() -> void:
	get_tree().change_scene_to_file("res://all scenes/Settings.tscn")
	
func _on_start_buttom_3_pressed() -> void:
	get_tree().quit()
