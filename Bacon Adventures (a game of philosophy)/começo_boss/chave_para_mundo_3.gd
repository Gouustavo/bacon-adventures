extends Area2D

@onready var transition: CanvasLayer = $"../transition"
@export var next_level: String = " "


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and !next_level == "":
		get_tree().change_scene_to_file("res://transition_world_03.tscn")
