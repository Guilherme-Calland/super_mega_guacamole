const UP = Vector2(0, -1)
var animationScript = load("res://Scripts/Animations.gd")
var movementScript = load("res://Scripts/Movement.gd")
var inputScript = load("res://Scripts/Input.gd")
var animation = animationScript.new()
var movement = movementScript.new()
var input = inputScript.new()

var hurt = false

var motionBundle = {
	"motion" : Vector2(0,0),
	"direction" : "left"
}

var animationBundle = {
	"hurtAnimation" : false
}

var inputBundle = {
	"right" : false,
	"left" : false,
	"jump" : false,
	"grab" : false
}
