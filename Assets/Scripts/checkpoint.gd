extends Node2D
class_name Checkpoint

var spawnpoint = false

var activated = false

func activate():
	$AudioStreamPlayer2D.play()
	GameManager.current_checkpoint = self
	GameManager.checkpoints += 1
	activated = true
	$AnimatedSprite2D.play("default")
	
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !activated:
		area.get_parent().change_animation()
		activate()
