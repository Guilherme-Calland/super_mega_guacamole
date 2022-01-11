extends Area2D

func _on_Hazard_body_entered(body):
	if not body.ducking:
		body.hurt()
