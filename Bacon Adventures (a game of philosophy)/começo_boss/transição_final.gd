extends CanvasLayer

@onready var anim = $ColorRect/anim

func _ready():
	anim.play("xp")
	trocar_depois_de_tempo()

func trocar_depois_de_tempo() -> void:
	await get_tree().create_timer(8.0).timeout
	get_tree().change_scene_to_file("res://agradecimentos.tscn")
