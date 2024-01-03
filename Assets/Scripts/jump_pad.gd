extends Node2D

@export var force = -5000.0

func _on_area_2d_area_entered(area):
	$AudioStreamPlayer2D.play()
	$animaciones.play("back")
	if area.get_parent() is Player:
		area.get_parent().velocity.y = force
		area.get_parent().jump_site = 0.0
		
func _on_animaciones_animation_finished():	
	$animaciones.play("idle")
