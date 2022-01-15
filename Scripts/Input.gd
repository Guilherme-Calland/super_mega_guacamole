func retrieveInput():
	var inputBundle = {
		"right" : false,
		"left" : false,
		"jump" : false,
		"grab" : false
	}
	
	if Input.is_action_pressed("right"):
		inputBundle["right"] = true
	
	if Input.is_action_pressed("left"):
		inputBundle["left"] = true
		
	if Input.is_action_pressed("jump"):
		inputBundle["jump"] = true
		
	if Input.is_action_pressed("grab"):
		inputBundle["grab"] = true
	
	return inputBundle
