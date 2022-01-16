func animate(sprite, isOnFloor, isOnWall, direction, hurtAnimation, inputBundle):
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if direction == "right":
		sprite.flip_h = false
	elif direction == "left":
		sprite.flip_h = true
	
	if isOnFloor:
		if (right and left) or not(right or left):
			sprite.play("idle")
		elif direction == "right" || "right":
			sprite.play("run")
			
		if jump:
			sprite.play("jump")
	
	if (isOnFloor or isOnWall) and hurtAnimation:
		hurtAnimation = false
	
	if not isOnFloor:
		sprite.play("jump")
		
	if isOnWall:
		sprite.play("pregrab")
		if grab:
			sprite.play("grab")
		
	if hurtAnimation:
		sprite.play("hurt")
		
	var animationBundle = {
		"hurtAnimation" : hurtAnimation
	}
	
	return animationBundle
	
