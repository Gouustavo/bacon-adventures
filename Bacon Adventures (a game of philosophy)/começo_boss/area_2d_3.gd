extends Area2D

@export var damage := 1
@export var knockback_force := 300.0

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		# Knockback pra cima (vetor vertical)
		var knockback = Vector2(0, -knockback_force)
		body.take_damage(knockback)
