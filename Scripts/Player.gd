extends KinematicBody2D
class_name Player

const UP = Vector2(0, -1)
export var gravity = 10
export var speed = 100
export var jump_speed = 300
var motion = Vector2(0,0)
var animationScript = load("res://Scripts/Animations.gd")
var animation = animationScript.new()

func _physics_process(delta):
	move_and_slide(motion, UP)
	animation.animate(is_on_floor(), $PlayerAnimatedSprite)
	
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		if is_on_floor():
			motion.x = speed
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		if is_on_floor():
			motion.x = -speed
	else:
		if is_on_floor():
			motion.x = 0
		
	if not is_on_floor():
		motion.y += gravity
	else:
		motion.y = 0
	
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			motion.y -= jump_speed

