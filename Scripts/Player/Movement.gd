func move(speed, gravity, jumpSpeed, wallPushForce, isOnFloor, isOnWall, isOnCeiling, wallCollisionDirection, motionBundle, inputBundle):
	var motion = motionBundle["motion"]
	var direction = motionBundle["direction"]
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if not(right or left) or (right and left):
		if isOnFloor:
			motion.x = 0
	elif right:
		if isOnFloor:
			motion.x = speed
	elif left:
		if isOnFloor:
			motion.x = -speed
		
	if not isOnFloor and not isOnCeiling:
		motion.y += gravity
	else:
		motion.y = gravity
		
	if jump and isOnFloor:
		motion.y = -jumpSpeed
	
	if isOnWall:
		wallCollisionDirection = direction
		if grab:
			motion.y = 0
		if jump:
			motion.y = -jumpSpeed
			if direction == "right":
				motion.x = -wallPushForce
			elif direction == "left":
				motion.x = wallPushForce
	
		if wallCollisionDirection == "right":
			if motion.x > 0:
				motion.x = 5
				#the big value fixes the
				#is_on_wall flickering animation
				# and also the world stops trembling
		elif wallCollisionDirection == "left":
			if motion.x < 0:
				motion.x = -5
	
	if isOnFloor:
		wallCollisionDirection = "none"
	
	if motion.x > 0:
		direction = "right"
	elif motion.x < 0:
		direction = "left"
	
	motionBundle = {
		"motion" : motion,
		"direction" : direction,
		"wallCollisionDirection" : wallCollisionDirection
	}
	
	return motionBundle
