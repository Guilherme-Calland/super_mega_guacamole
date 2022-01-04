extends KinematicBody2D

export var gravity = 10
export var speed = 100
export var jump_speed = 300

var hurt_animation = false

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
	var floor_count_buffer = u.motionBundle["floor_count_buffer"]
	
	print(floor_count_buffer)
	
	u.motionBundle = u.movement.move(
		motion, 
		speed, 
		gravity, 
		jump_speed, 
		is_on_floor(),
		hurt,
		floor_count_buffer
		)
		
	move_and_slide(motion, u.UP)
	
func animate():
	
	var hurt = u.motionBundle["hurt"]
	
	u.animation.animate(
		is_on_floor(), 
		$PlayerAnimatedSprite, 
		is_on_wall(),
		hurt
		)

func hurt():
	u.motionBundle["hurt"] = true
