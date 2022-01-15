const UP = Vector2(0, -1)
var animationScript = load("res://Scripts/Animations.gd")
var movementScript = load("res://Scripts/Movement.gd")
var animation = animationScript.new()
var movement = movementScript.new()

var motionBundle = {
	"motion" : Vector2(0,0),
	"hurt" : false,
}

var animationBundle = {
	"hurtAnimation" : false
}

var inputBundle = {
	"right" : false,
	"left" : false,
	"jump" : false
}
