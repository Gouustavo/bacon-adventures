extends Area2D

@onready var anim: AnimatedSprite2D = $anim
var is_active = false

func _on_body_entered(body: Node2D) -> void:
	if body.name != "player" or is_active:
		return
	
func _on_anim_animation_finished() -> void:
	if anim.animation == "raising":
		anim.play("checked")
