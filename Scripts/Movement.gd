func move(speed, gravity, jump_speed, wall_push_force, is_on_floor, is_on_wall, motionBundle, inputBundle, hurt):
	var motion = motionBundle["motion"]
	var direction = motionBundle["direction"]
	var left = inputBundle["left"]
	var right = inputBundle["right"]
	var jump = inputBundle["jump"]
	var grab = inputBundle["grab"]
	
	if right and not left:
		if is_on_floor:
			direction = "right"
			motion.x = speed
	elif left and not right:
		if is_on_floor:
			direction = "left"
			motion.x = -speed
	else:
		if is_on_floor:
			motion.x = 0
		
	if not is_on_floor:
		motion.y += gravity
	elif is_on_floor:
		motion.y = gravity
	
	if jump and is_on_floor:
		motion.y = -jump_speed
	
	if is_on_wall:
		if grab:
			motion.y = 0
		if jump:
			motion.y = -jump_speed
			if direction == "right":
				motion.x = -wall_push_force
				direction = "left"
			else:
				motion.x = wall_push_force
				direction = "right"
		
	if hurt:
		motion.y = -jump_speed
		hurt = false
	
	motionBundle = {
		"motion" : motion,
		"direction" : direction
	}
	
	return motionBundle
