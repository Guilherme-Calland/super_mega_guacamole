extends KinematicBody2D

export var gravity = 10
export var speed = 100
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
	var prevMotion = u.motionBundle["motion"]
	var prevDirection = u.motionBundle["direction"]
	var prevIsOnWall = is_on_wall()
	move_and_slide(prevMotion, u.UP)
	
	u.motionBundle = u.movement.move(
		speed, 
		gravity, 
		jumpSpeed, 
		wallPushForce,
		isOnFloor(u.motionBundle["motion"]),
		is_on_wall(),
		justOnWallStatus(prevIsOnWall, prevDirection),
		u.motionBundle,
		u.inputBundle
		)
		
	
func animate():
	u.animationBundle = u.animation.animate(
		$PlayerAnimatedSprite,
		is_on_floor(), 
		is_on_wall(),
		u.animationBundle["hurtAnimation"],
		u.motionBundle["motion"],
		u.inputBundle
		)

func hurt():
	u.motionBundle["hurtMovement"] = true
	u.animationBundle["hurtAnimation"] = true
	
func isOnFloor(motion):
	var isOnFloor = is_on_floor()
	if motion.y < 0:
		isOnFloor = false
	return isOnFloor

func justOnWallStatus(wasOnWall, direction):
	if wasOnWall != is_on_wall():
		if !is_on_wall():
			if direction == "right":
				return "justOnRightWall"
			elif direction == "left":
				return "justOnLeftWall"
	return "notJustOnWall"
