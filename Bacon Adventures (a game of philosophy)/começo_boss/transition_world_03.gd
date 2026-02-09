extends CanvasLayer

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("play_anim")
	trocar_depois_de_tempo()

func trocar_depois_de_tempo() -> void:
	await get_tree().create_timer(6.0).timeout
	get_tree().change_scene_to_file("res://mundo_03.tscn")
