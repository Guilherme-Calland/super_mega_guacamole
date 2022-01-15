func move(speed, gravity, jump_speed, is_on_floor, is_on_wall, motionBundle, inputBundle, hurt):
	var motion = motionBundle["motion"]
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if right and not left:
		if is_on_floor:
			motion.x = speed
	elif left and not right:
		if is_on_floor:
			motion.x = -speed
	else:
		if is_on_floor:
			motion.x = 0
		
	if not is_on_floor:
		if is_on_wall and grab:
			motion.y = 0
		else:
			motion.y += gravity
	elif is_on_floor:
		motion.y = gravity
	
	if jump and is_on_floor:
		motion.y = -jump_speed
	
	if hurt:
		motion.y = -jump_speed
		hurt = false
	
	motionBundle = {
		"motion" : motion,
		"hurt" : hurt,
	}
	
	return motionBundle
