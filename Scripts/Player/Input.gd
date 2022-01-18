extends Node2D

signal input

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		emit_signal("input", 10, -20)
	elif Input.is_action_just_pressed("checkPoint1"):
		emit_signal("input", 3000, -20)
	elif Input.is_action_just_pressed("checkPoint2"):
		emit_signal("input", 6000, -20)
	elif Input.is_action_just_pressed("checkPoint3"):
		emit_signal("input", 7800, -20)

func retrieveInput():
	var inputBundle = {
		"right" : false,
		"left" : false,
		"jump" : false,
		"grab" : false,
	}
	
	if Input.is_action_pressed("right"):
		inputBundle["right"] = true
	
	if Input.is_action_pressed("left"):
		inputBundle["left"] = true
		
	if Input.is_action_just_pressed("jump"):
		inputBundle["jump"] = true
		
	if Input.is_action_pressed("grab"):
		inputBundle["grab"] = true
		
	return inputBundle
