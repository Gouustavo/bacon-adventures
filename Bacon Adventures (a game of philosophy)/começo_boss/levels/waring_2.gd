extends Node2D

@onready var texture = $Sprite2D
@onready var area_sign = $Area2D
@onready var label = $Label

# As falas desse NPC
const lines: Array[String] = [
	"A ninguém te mostres muito íntimo, 
	pois familiaridade excessiva gera desprezo.",
	"Não se opor ao erro é aprová-lo,
	não defender a verdade é negá-la.",
	"A verdade é a adequação da mente à realidade.",
	"O estudo da filosofia não tem por objeto saber o que os homens pensavam,
	e sim, qual é a verdade das coisas.",
	"A humildade é o primeiro degrau para a sabedoria.",
]

func _unhandled_input(event):
	# Se o player estiver dentro da área do NPC
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		label.show()
		
		if event.is_action_pressed("interact") and !DialogManager.is_dialog_active:
			texture.hide()
			DialogManager.start_dialog(global_position + Vector2(-780, 430), lines) #(x, y) nessa ordem, pra vc não esquecer
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
