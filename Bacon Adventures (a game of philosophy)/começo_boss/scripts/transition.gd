extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
func _ready() -> void:
	show_new_scene()
	
func show_new_scene():
	var show_transition =  get_tree().create_tween()
	show_transition.tween_property(color_rect, "treshold", 0.0, 1).from(1)
