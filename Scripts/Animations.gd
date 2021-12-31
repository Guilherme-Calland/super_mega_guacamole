extends Node

func animate(is_on_floor, sprite):
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		sprite.flip_h = false
		if is_on_floor:
			sprite.play("run")
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		sprite.flip_h = true
		if is_on_floor:
			sprite.play("run")
	else:
		if is_on_floor:
			sprite.play("idle")
	if Input.is_action_pressed("jump"):
		if is_on_floor:
			sprite.play("jump")
	
