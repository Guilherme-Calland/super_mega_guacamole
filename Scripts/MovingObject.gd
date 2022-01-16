extends Node2D

export var direction = "still"
export var dislocationTime = 1
export var waitTime = 2

func _process(delta):
	if direction == "forward":
		position.x += 1
	elif direction == "backward":
		position.x -= 1

func _on_Timer_timeout():
	if direction == "still":
		$Timer.wait_time = dislocationTime
		direction = "backward"
	elif direction == "backward":
		$Timer.wait_time = dislocationTime
		direction = "forward"
	elif direction == "forward":
		$Timer.wait_time = waitTime
		direction = "still"
	$Timer.start()
