func move(motion, speed, gravity, jump_speed, is_on_floor, hasInertia, direction):
	
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		direction = "right"
		if is_on_floor:
			motion.x = speed
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		direction = "left"
		if is_on_floor:
			motion.x = -speed
	else:
		if is_on_floor:
			motion.x = 0
		
	if not is_on_floor:
		motion.y += gravity
	elif is_on_floor:
		motion.y = 1
	
	if Input.is_action_pressed("jump"):
		if is_on_floor:
			motion.y -= jump_speed

	#inertia
	if Input.is_action_just_released("right") || Input.is_action_just_released("left"):
		if is_on_floor:
			hasInertia = true
	
	if hasInertia:
		if direction == "right":
			motion.x += speed/ 2
		elif direction == "left":
			motion.x -= speed/ 2
	
	var motionBundle = {
		"motion" : motion,
		"inertia" : hasInertia,
		"direction" : direction
	}
	
	motionBundle["motion"] = motion
	motionBundle["inertia"] = hasInertia
	motionBundle["direction"] = direction
	
	return motionBundle
