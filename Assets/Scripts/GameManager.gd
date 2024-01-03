extends Node

var current_checkpoint : Checkpoint

var player : Player

var checkpoints = 0

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
	
if checkpoints = 4:
	
