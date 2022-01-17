const UP = Vector2(0, -1)
var animationScript = load("res://Scripts/Player/Animations.gd")
var movementScript = load("res://Scripts/Player/Movement.gd")
var inputScript = load("res://Scripts/Player/Input.gd")
var animation = animationScript.new()
var movement = movementScript.new()
var input = inputScript.new()

var motionBundle = {
	"motion" : Vector2(0,0),
	"direction" : "left",
	"wallCollisionDirection" : "none"
}

var animationBundle = {
	"hurtAnimation" : false
}

var inputBundle = {
	"right" : false,
	"left" : false,
	"jump" : false,
	"grab" : false,
	"restart" : false,
	"checkPoint1" : false,
	"checkPoint2" : false
}
