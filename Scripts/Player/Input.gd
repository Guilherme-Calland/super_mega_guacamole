func retrieveInput():
	var inputBundle = {
		"right" : false,
		"left" : false,
		"jump" : false,
		"grab" : false,
		"restart" : false,
		"checkPoint1" : false,
		"checkPoint2" : false
	}
	
	if Input.is_action_pressed("right"):
		inputBundle["right"] = true
	
	if Input.is_action_pressed("left"):
		inputBundle["left"] = true
		
	if Input.is_action_just_pressed("jump"):
		inputBundle["jump"] = true
		
	if Input.is_action_pressed("grab"):
		inputBundle["grab"] = true
	
	if Input.is_action_just_pressed("restart"):
		inputBundle["restart"] = true
		
	if Input.is_action_pressed("checkPoint1"):
		inputBundle["checkPoint1"] = true
		
	if Input.is_action_pressed("checkPoint2"):
		inputBundle["checkPoint2"] = true
		
	return inputBundle
