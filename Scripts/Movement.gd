func move(motion, speed, gravity, jump_speed, is_on_floor, hasInertia, direction):
	
	var motionBundle : Array = [motion.x, motion.y, hasInertia, direction]
	
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
	
	motionBundle[0] = motion.x
	motionBundle[1] = motion.y
	motionBundle[2] = hasInertia
	motionBundle[3] = direction
	
	return motionBundle
