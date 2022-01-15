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
	var motion : Vector2 = u.motionBundle["motion"]
	var hurt = u.motionBundle["hurt"]
	
	move_and_slide(motion, u.UP)
	
	u.motionBundle = u.movement.move(
		motion, 
		speed, 
		gravity, 
		jump_speed, 
		checkIfOnFloor(motion),
		u.motionBundle["hurt"]
		)
		
	
func animate():
	u.animationBundle = u.animation.animate(
		is_on_floor(), 
		$PlayerAnimatedSprite, 
		is_on_wall(),
		u.animationBundle["hurtAnimation"],
		u.motionBundle["motion"]
		)

func hurt():
	u.motionBundle["hurt"] = true
	u.animationBundle["hurtAnimation"] = true
	
func checkIfOnFloor(motion):
	var is_on_floor = is_on_floor()
	if motion.y < 0:
		is_on_floor = false
	return is_on_floor
