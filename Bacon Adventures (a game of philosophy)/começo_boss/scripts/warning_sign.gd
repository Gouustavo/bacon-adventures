extends Node2D

@onready var texture = $texture
@onready var area_sign = $area_sign

const lines: Array[String] = [
  "Olá, aventureiro!",
  "É muito bom vê-lo por aqui",
  "Espero que esteja preparado...",
  "Sua jornada está apenas...",
  "...COMEÇANDO!",
]

func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		print("Detectou corpo dentro da área")
		texture.show()
		if event.is_action_pressed("interact") and !DialogManager.is_message_active:
			print("Interagiu!")
			texture.hide()
			DialogManager.start_message(global_position, lines)
