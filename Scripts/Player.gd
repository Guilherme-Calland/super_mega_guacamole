extends KinematicBody2D

const UP = Vector2(0, -1)
export var gravity = 10
export var speed = 100
export var jump_speed = 300
var motion = Vector2(0,0)
var animationScript = load("res://Scripts/Animations.gd")
var movementScript = load("res://Scripts/Movement.gd")
var animation = animationScript.new()
var movement = movementScript.new()

func _physics_process(delta):
	move()
	animate()
	
func move():
	motion = movement.move(motion, speed, gravity, jump_speed, is_on_floor())
	move_and_slide(motion, UP)
	
func animate():
	animation.animate(is_on_floor(), $PlayerAnimatedSprite)
	


