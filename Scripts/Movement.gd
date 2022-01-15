func move(motionBundle, speed, gravity, jump_speed, is_on_floor, inputBundle):
	
	var motion = motionBundle["motion"]
	var hurt = motionBundle["hurt"]
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	
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
		motion.y += gravity
	elif is_on_floor:
		motion.y = gravity
	
	if jump:
		if is_on_floor:
			motion.y = -jump_speed
	
	if hurt:
		motion.y = -jump_speed
		hurt = false
	
	motionBundle = {
		"motion" : motion,
		"hurt" : hurt,
	}
	
	return motionBundle
