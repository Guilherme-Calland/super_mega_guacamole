const UP = Vector2(0, -1)
var motion = Vector2(0,0)
var animationScript = load("res://Scripts/Animations.gd")
var movementScript = load("res://Scripts/Movement.gd")
var animation = animationScript.new()
var movement = movementScript.new()

var motionBundle : Array = [0.0, 0.0, false, "right"]
