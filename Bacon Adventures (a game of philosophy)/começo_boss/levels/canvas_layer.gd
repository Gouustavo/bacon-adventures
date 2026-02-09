extends CanvasLayer

@onready var dialog_scene = preload("res://dialog.tscn")
var current_dialog = null

func show_dialog(texto: String, pos: Vector2):
	if current_dialog:
		current_dialog.queue_free()
	current_dialog = dialog_scene.instantiate()
	add_child(current_dialog)
	current_dialog.global_position = pos
	current_dialog.display_text(texto)
	await current_dialog.text_display_finished
	current_dialog.queue_free()
	current_dialog = null
