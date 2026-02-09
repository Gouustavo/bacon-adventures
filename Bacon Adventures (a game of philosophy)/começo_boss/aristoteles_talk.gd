extends CanvasLayer

@onready var exit: Button = $exit

func _ready() -> void:
	visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_exit_pressed() -> void:
	get_tree().paused = false
	visible= false
	exit.grab_focus()
