func move(speed, gravity, jumpSpeed, wallPushForce, isOnFloor, isOnWall, isOnCeiling, motionBundle, inputBundle):
	var motion = motionBundle["motion"]
	var direction = motionBundle["direction"]
	var hurtMovement = motionBundle["hurtMovement"]
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if right and not left:
		if isOnFloor:
			direction = "right"
			motion.x = speed
	elif left and not right:
		if isOnFloor:
			direction = "left"
			motion.x = -speed
	else:
		if isOnFloor:
			motion.x = 0
		
	if not isOnFloor:
		if not isOnCeiling:
			motion.y += gravity
		elif isOnCeiling:
			motion.y = gravity
	
	elif isOnFloor:
		motion.y = gravity
		
	if jump and isOnFloor:
		motion.y = -jumpSpeed
	
	if isOnWall:
		if grab:
			motion.y = 0
		if jump:
			motion.y = -jumpSpeed
			if direction == "right":
				motion.x = -wallPushForce
				direction = "left"
			else:
				motion.x = wallPushForce
				direction = "right"
	
#	if justOnWallStatus == "justOnRightWall":
#		if motion.x > 0:
#			motion.x = -1;
#	elif justOnWallStatus == "justOnLeftWall":
#		if motion.x < 0:
#			motion.x = 1
	
	if hurtMovement:
		motion.y = -jumpSpeed
		hurtMovement = false
		
	motionBundle = {
		"motion" : motion,
		"direction" : direction,
		"hurtMovement" : hurtMovement
	}
	
	return motionBundle
