extends Node

var is_message_active: bool = false
@onready var dialog_scene = preload("res://dialog.tscn")

var dialog_lines : Array[String] = []
var current_line_index = 0

var text_box
var text_box_position = Vector2.ZERO

var is_dialog_active = false
var can_advance_message = false

func start_dialog(position: Vector2, lines: Array[String]):
	if is_dialog_active:
		return
		
	dialog_lines = lines
	text_box_position = position + Vector2(-70, -130) # <-- desloca o balão para cima
	_show_text_box()
	
	is_dialog_active = true
	
	
func _show_text_box():
	text_box = dialog_scene.instantiate()
	text_box.finished_displaying.connect(_on_all_text_displayed)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_message = false
	
func _on_all_text_displayed():
	can_advance_message = true
	
func _unhandled_input(event):
	if(
		event.is_action_pressed("advance") &&
		is_dialog_active && 
		can_advance_message
	):
		text_box.queue_free()
		
		current_line_index += 1 
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			return
			
		_show_text_box()
