func move(motion, speed, gravity, jump_speed, is_on_floor, hurt):
	
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		if is_on_floor:
			motion.x = speed
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
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

	if hurt:
		if is_on_floor:
			motion.y -= jump_speed/2
	
	if is_on_floor:
		hurt = false
	
	var motionBundle = {
		"motion" : motion,
		"hurt" : false
	}
	
	return motionBundle
