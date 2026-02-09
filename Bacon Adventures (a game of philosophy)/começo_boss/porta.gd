extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("open")
		await get_tree().create_timer(3.0).timeout
		
		get_tree().change_scene_to_file("res://transição_final.tscn")
