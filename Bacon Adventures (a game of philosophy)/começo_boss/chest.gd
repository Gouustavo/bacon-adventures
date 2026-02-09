extends Area2D

@onready var anima: AnimatedSprite2D = $anima
signal heart_given

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		anima.play("open")

# cuidado: isso pode cancelar a animação "open" antes de terminar!
# só volte para idle se NÃO estiver tocando "open"
func _on_animated_sprite_2d_animation_finished() -> void:
	if anima.animation == "open":  # ou &"open" em Godot 4
		emit_signal("heart_given")     # dispara para o Player
		$CollisionShape2D.disabled = true  # evita repetir
		monitoring = false
	
func _on_anima_animation_finished() -> void:
	if anima.animation == "open":
		emit_signal("heart_given")
		anima.play("idle") # volta pro estado base
