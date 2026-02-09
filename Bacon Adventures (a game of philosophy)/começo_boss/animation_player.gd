extends Node

@onready var anim_player: AnimationPlayer = $"."  # garante que tá pegando o nó certo
@export var anim_name: String = "play_anim"
@export var forced_duration: float = 6.0

func _ready():
	if not anim_player.has_animation(anim_name):
		push_error("Anima=ção '%s' não encontrada no AnimationPlayer!" % anim_name)
		return

	var anim_length = anim_player.get_animation(anim_name).length
	var required_speed = anim_length / forced_duration

	print("🟢 Iniciando animação '%s'" % anim_name)
	print("⏱ Duração original:", anim_length)
	print("⚙️ Velocidade ajustada:", required_speed)

	anim_player.play(anim_name, -1, required_speed, false)

	await get_tree().create_timer(forced_duration).timeout
