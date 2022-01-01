const UP = Vector2(0, -1)
var motion = Vector2(0,0)
var animationScript = load("res://Scripts/Animations.gd")
var movementScript = load("res://Scripts/Movement.gd")
var animation = animationScript.new()
var movement = movementScript.new()

var motionBundle = {
	"motion x" : 0.0,
	"motion y" : 0.0,
	"inertia" : false,
	"direction" : "right"
}
