extends Area2D

var coins := 1
@onready var coin_sfx: AudioStreamPlayer = $coin_sfx

func _on_body_entered(body: Node2D) -> void:
	$Anim.play("collect")
	coin_sfx.play()
	await $collision.call_deferred("queue_free")
	Globals.coins += coins
	print(Globals.coins)

func _on_anim_animation_finished() -> void:
	await get_tree().create_timer(0.3).timeout  # espera o som tocar
	queue_free()
