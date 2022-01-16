extends KinematicBody2D

export var gravity = 10
export var speed = 200
export var jumpSpeed = 300
export var wallPushForce = 300

var u

func _ready():
	var utilsScript = load("res://Scripts/Utils.gd")
	u = utilsScript.new()

func _physics_process(delta):
	retrieveInput()
	move()
	animate()
	
func retrieveInput():
	u.inputBundle = u.input.retrieveInput()
	
func move():
	var motion = u.motionBundle["motion"]
	# once move_and slide is called this changes the
	# is_on_wall() and is_on_ceiling()
	move_and_slide(motion, u.UP)
	var wallCollisionDirection = u.motionBundle["wallCollisionDirection"]
	u.motionBundle = u.movement.move(
		speed, 
		gravity, 
		jumpSpeed, 
		wallPushForce,
		isOnFloor(motion),
		is_on_wall(),
		is_on_ceiling(),
		wallCollisionDirection,
		u.motionBundle,
		u.inputBundle
		)
	
func animate():
	var motion = u.motionBundle["motion"]
	var direction = u.motionBundle["direction"]
	u.animationBundle = u.animation.animate(
		$PlayerAnimatedSprite,
		isOnFloor(motion), 
		is_on_wall(),
		direction,
		u.animationBundle["hurtAnimation"],
		u.inputBundle
		)

func hurt(throwDirection):
	var direction
	if throwDirection.x > 0:
		direction = "right"
	else:
		direction = "left"
	
	u.motionBundle["motion"] = throwDirection
	u.motionBundle["direction"] = direction
	u.animationBundle["hurtAnimation"] = true

func boost(boostForce):
	var direction
	u.motionBundle["motion"] = boostForce
	if boostForce.x > 0:
		direction = "right"
	else:
		direction = "left"
	u.motionBundle["direction"] = direction

func isOnFloor(motion):
	var isOnFloor = is_on_floor()
	if motion.y < 0:
		isOnFloor = false
	return isOnFloor

func isGrabbing():
	print(is_on_wall())
	print(Input.is_action_pressed("grab"))
	return is_on_wall() and u.inputBundle["grab"]
	
