func animate(is_on_floor, sprite, is_on_wall, hurtAnimation, motion, inputBundle):
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	
	if right and not left:
		sprite.flip_h = false
		sprite.play("run")
	elif left and not right:
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
		
	if hurtAnimation:
		sprite.play("hurt")
		
	var animationBundle = {
		"hurtAnimation" : hurtAnimation
	}
	
	return animationBundle
	
func falling(motion):
	return motion.y > 0
