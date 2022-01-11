extends KinematicBody2D

var motion = Vector2(0,0)
const GRAVITY = 10
const UP = Vector2(0, -1)

func _process(delta):
	if not is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = 0
		
	if position.y > 1000:
		queue_free()
	
	move_and_slide(motion, UP)

func _on_Timer_timeout():
	motion.x = 0

func move_right():
	$Timer.start()
	motion.x = 200
	print("hello")

func move_left():
	$Timer.start()
	motion.x = -200
