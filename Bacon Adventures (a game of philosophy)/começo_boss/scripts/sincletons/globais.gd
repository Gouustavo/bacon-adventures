extends Node

var player = null
var player_life = 3
var current_checkpoint = 0
var coins := 0
var score := 0
var chest := 0

func respanw_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
