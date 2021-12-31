extends KinematicBody2D
class_name Player

const UP = Vector2(0, -1)
export var gravity = 10
export var speed = 100
export var jump_speed = 300
var motion = Vector2(0,0)

func _physics_process(delta):
	move_and_slide(motion, UP)
	
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		$PlayerAnimatedSprite.flip_h = false
		if is_on_floor():
			$PlayerAnimatedSprite.play("run")
			motion.x = speed
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		$PlayerAnimatedSprite.flip_h = true
		if is_on_floor():
			motion.x = -speed
			$PlayerAnimatedSprite.play("run")
	else:
		if is_on_floor():
			motion.x = 0
			$PlayerAnimatedSprite.play("idle")
		
	if not is_on_floor():
		motion.y += gravity
	else:
		motion.y = 0
	
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			motion.y -= jump_speed
			$PlayerAnimatedSprite.play("jump")

