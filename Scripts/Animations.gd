func animate(sprite, is_on_floor, is_on_wall, hurtAnimation, motion, inputBundle):
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if is_on_floor:
		if right and not left:
			sprite.flip_h = false
			sprite.play("run")
		elif left and not right:
			sprite.flip_h = true
			sprite.play("run")
		else:
			sprite.play("idle")
			
		if jump:
			sprite.play("jump")
		if falling(motion):
			hurtAnimation = false
	
	if not is_on_floor:
		sprite.play("jump")
		
	if is_on_wall:
		if jump:
			sprite.flip_h = not sprite.flip_h
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
