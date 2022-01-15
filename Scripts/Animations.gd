func animate(sprite, is_on_floor, is_on_wall, hurtAnimation, motion, inputBundle):
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if right and not left:
		if not is_on_wall:
			sprite.flip_h = false
		sprite.play("run")
	elif left and not right:
		if not is_on_wall:
			sprite.flip_h = true
		sprite.play("run")
	else:
		sprite.play("idle")
	
	if is_on_floor:
		if jump:
			sprite.play("jump")
		if falling(motion):
			hurtAnimation = false
	
	if not is_on_floor:
		sprite.play("jump")
		
	if is_on_wall:
		sprite.play("pregrab")
		if grab:
			sprite.play("grab")
		
	if hurtAnimation:
		sprite.play("hurt")
		
	var animationBundle = {
		"hurtAnimation" : hurtAnimation
	}
	
	return animationBundle
	
func falling(motion):
	return motion.y > 0
