func animate(is_on_floor, sprite, is_on_wall):
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		sprite.flip_h = false
		sprite.play("run")
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		sprite.flip_h = true
		sprite.play("run")
	else:
		sprite.play("idle")

	if not is_on_floor && not is_on_wall:
		sprite.play("jump")
