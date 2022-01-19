extends KinematicBody2D

export var gravity = 10
export var speed = 200
export var jumpSpeed = 300
export var wallPushForce = 300

var u

func _ready():
	$Input.connect("input", self, "teleport")
	var utilsScript = load("res://Scripts/Player/Utils.gd")
	u = utilsScript.new()

func _physics_process(delta):
	retrieveInput()
	move()
	animate()
	
func teleport(posX, posY):
	position = Vector2(posX, posY)

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

func hurt(throwForce):
	u.motionBundle["motion"] = throwForce
	u.animationBundle["hurtAnimation"] = true

func boost(boostForce):
	u.motionBundle["motion"] = boostForce

func isOnFloor(motion):
	var isOnFloor = is_on_floor()
	if motion.y < 0:
		isOnFloor = false
	return isOnFloor

