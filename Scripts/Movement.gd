func move(motion, speed, gravity, jump_speed, is_on_floor, hurt, floor_count_buffer):
	
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
		motion.y = gravity
	
	if Input.is_action_pressed("jump") or hurt:
		if is_on_floor:
			motion.y -= jump_speed
	
	if hurt:
		floor_count_buffer -= 1
	
	if is_on_floor and floor_count_buffer <= 0:
		hurt = false
		floor_count_buffer = 4
	
	
	var motionBundle = {
		"motion" : motion,
		"hurt" : hurt,
		"floor_count_buffer" : floor_count_buffer
	}
	
	return motionBundle
