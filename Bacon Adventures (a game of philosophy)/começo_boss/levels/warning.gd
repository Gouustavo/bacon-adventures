extends Node2D

@onready var texture = $texture
@onready var area_sign = $area_sign
@onready var label = $Label

# As falas desse NPC
const lines: Array[String] = [
	"O sábio nunca diz tudo o que pensa,
	mas pensa sempre tudo o que diz.",
	"A dúvida é o princípio da sabedoria.",
	"A educação tem raízes amargas,
	mas os seus frutos são doces.",
	"As pessoas dividem-se entre aquelas 
	que poupam como se vivessem para sempre 
	e aquelas que gastam como se fossem morrer amanhã.",
	"O sábio procura a ausência de dor, e não o prazer.",
	"Sócrates é meu amigo, mas sou mais amigo da verdade.",
	"Todos os homens, por natureza, desejam saber."
]

func _unhandled_input(event):
	# Se o player estiver dentro da área do NPC
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		label.show()

		# Se o jogador pressionar "interact" e não tem diálogo ativo
		if event.is_action_pressed("interact") and !DialogManager.is_dialog_active:
			texture.hide()
			DialogManager.start_dialog(global_position + Vector2(-240, 100), lines) #(x, y) nessa ordem, pra vc não esquecer
			# ^ posição do balão acima do NPC

	else:
		texture.hide()
		label.hide()

		# Se sair da área, fecha o balão se existir
		if DialogManager.text_box != null:
			DialogManager.text_box.queue_free()
			DialogManager.is_message_active = false
			DialogManager.is_dialog_active = false 
			DialogManager.current_line_index = 0
