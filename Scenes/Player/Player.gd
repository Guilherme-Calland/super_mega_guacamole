extends KinematicBody2D

func _process(delta):
	if Input.is_action_pressed("right"):
		position.x += 5
	elif Input.is_action_pressed("left"):
		position.x -= 5
