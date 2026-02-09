extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		# Faz o player quicar
		body.velocity.y = body.JUMP_FORCE
		
		# Avisa o inimigo (owner) que levou dano
		if owner and owner.has_method("take_damage"):
			owner.take_damage()
		
		queue_free()
