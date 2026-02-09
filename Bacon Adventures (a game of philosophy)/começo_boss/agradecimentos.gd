extends CanvasLayer

@onready var anim = $ColorRect/AnimationPlayer

func _ready():
	anim.play("fade")
	trocar_depois_de_tempo()

func trocar_depois_de_tempo() -> void:
	await get_tree().create_timer(8.0).timeout
	get_tree().change_scene_to_file("res://title_screen.tscn")
