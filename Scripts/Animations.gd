func animate(sprite, isOnFloor, isOnWall, direction, hurtAnimation, inputBundle):
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if isOnFloor:
		if (right and left) or not(right or left):
			sprite.play("idle")
		elif direction == "right":
			sprite.flip_h = false
			sprite.play("run")
		elif direction == "left":
			sprite.flip_h = true
			sprite.play("run")
			
		if jump:
			sprite.play("jump")
	
	if (isOnFloor or isOnWall) and hurtAnimation:
		hurtAnimation = false
		if isOnWall:
			sprite.flip_h = not sprite.flip_h
	
	if not isOnFloor:
		sprite.play("jump")
		
	if isOnWall:
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
	
