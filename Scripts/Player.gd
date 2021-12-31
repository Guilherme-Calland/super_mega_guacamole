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
	u.motion = u.movement.move(u.motion, speed, gravity, jump_speed, is_on_floor())
	move_and_slide(u.motion, u.UP)
	
func animate():
	u.animation.animate(is_on_floor(), $PlayerAnimatedSprite)
