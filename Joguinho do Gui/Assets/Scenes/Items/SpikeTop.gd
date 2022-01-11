extends Area2D

export var facingDown = false

func _on_SpikeTop_body_entered(body):
	if not facingDown:
		body.hurt()
	else:
		if not body.ducking:
			body.hurt()
