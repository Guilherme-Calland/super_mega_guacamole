extends KinematicBody2D

export var gravity = 10
export var speed = 100
export var jump_speed = 300

var u

func _ready():
	var utilsScript = load("res://Scripts/Utils.gd")
	u = utilsScript.new()

func _physics_process(delta):
	move()
	animate()
	
func move():
	var motion = Vector2(u.motionBundle["motion"])
	
	u.motionBundle = u.movement.move(
		motion, 
		speed, 
		gravity, 
		jump_speed, 
		is_on_floor()
		)
		
	move_and_slide(motion, u.UP)
	
func animate():
	u.animation.animate(is_on_floor(), $PlayerAnimatedSprite)
