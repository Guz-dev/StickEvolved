extends RigidBody2D


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		if area.get_parent().arms:
			area.get_parent().grab = true

func _on_area_2d_area_exited(area):
	if area.get_parent() is Player:
		if area.get_parent().arms:
			area.get_parent().grab = false
