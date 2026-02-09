extends Node2D

@onready var area_sign = $Area2D

const lines: Array[String] = [
		"Se a dor é o que nos faz perceber que estamos vivos...
então, ao buscar eliminar todo sofrimento, o que restaria de nós?"
]

func _unhandled_input(event):
	# Se o player estiver dentro da área do NPC
	if area_sign.get_overlapping_bodies().size() > 0:

		# Se o jogador pressionar "interact" e não tem diálogo ativo
		if event.is_action_pressed("interact") and !DialogManager.is_dialog_active:
			DialogManager.start_dialog(global_position + Vector2(-240, 100), lines) #(x, y) nessa ordem, pra vc não esquecer
			# ^ posição do balão acima do NPC

		# Se sair da área, fecha o balão se existir
		if DialogManager.text_box != null:
			DialogManager.text_box.queue_free()
			DialogManager.is_message_active = false
			DialogManager.is_dialog_active = false 
			DialogManager.current_line_index = 0
