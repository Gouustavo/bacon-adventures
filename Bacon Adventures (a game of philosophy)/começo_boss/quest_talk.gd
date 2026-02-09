extends Control

func _on_button_pressed() -> void:
	queue_free()
	get_tree().current_scene.get_node("Door").queue_free()
	queue_free()


func _on_button_2_pressed() -> void:
	queue_free()
	get_tree().current_scene.get_node("Door").queue_free()
	queue_free()
