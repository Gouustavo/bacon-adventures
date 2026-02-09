extends Area2D

@export var quest_popup_scene: PackedScene   # deixe só isso
@export var popup_offset := Vector2(-40, -30)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	# 1. Instancia o popup
	var popup = quest_popup_scene.instantiate()

	# 2. Adiciona o popup na cena atual
	get_tree().current_scene.add_child(popup)

	# 3. Coloca o popup abaixo do player
	var popup_position = body.global_position + popup_offset
	popup.global_position = popup_position

	# 4. Remove o trigger
	call_deferred("queue_free")
