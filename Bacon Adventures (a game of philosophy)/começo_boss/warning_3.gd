extends Node2D

@onready var texture = $Sprite2D
@onready var area_sign = $Area2D
@onready var label = $Label

# As falas desse NPC
const lines: Array[String] = [
	"A beleza salvará o mundo.",
	"A vida é suportável apenas pela 
	esperança de que a morte é uma ilusão.",
	"Aquele que tem sentimentos sofre reconhecendo o seu erro. 
	É seu castigo, independente da prisão",
	"No nosso planeta só podemos amar sofrendo e através da dor. 
	Não sabemos amar de outro modo nem conhecemos outro tipo de amor.",
	"Às vezes o homem prefere o sofrimento à paixão.",
	"A maior felicidade é quando a pessoa sabe porque é que é infeliz.",
]

func _unhandled_input(event):
	# Se o player estiver dentro da área do NPC
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		label.show()
		
		if event.is_action_pressed("interact") and !DialogManager.is_dialog_active:
			texture.hide()
			DialogManager.start_dialog(global_position + Vector2(-200, 430), lines) #(x, y) nessa ordem, pra vc não esquecer
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
