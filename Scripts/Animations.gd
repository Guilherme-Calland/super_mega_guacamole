func animate(is_on_floor, sprite, is_on_wall, hurtAnimation, motion):
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		sprite.flip_h = false
		sprite.play("run")
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		sprite.flip_h = true
		sprite.play("run")
	else:
		sprite.play("idle")
	
	if is_on_floor:
		if Input.is_action_pressed("jump"):
			sprite.play("jump")
		if motion.y > 0:
			hurtAnimation = false
	
	if not is_on_floor:
		sprite.play("jump")
		
	if is_on_wall:
		sprite.play("grab")
		
	if hurtAnimation:
		sprite.play("hurt")
		
	var animationBundle = {
		"hurtAnimation" : hurtAnimation
	}
	
	return animationBundle
