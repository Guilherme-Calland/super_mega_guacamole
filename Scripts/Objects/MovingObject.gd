extends Node2D

export var direction = "still"
export var dislocation = 100
var dislocationCounter = 0
export var waitTime = 2
export var throwDirection = Vector2(-10, -50)

func _ready():
	$Timer.wait_time = waitTime

func _process(delta):
	if direction == "forward":
		dislocationCounter += 1
		position.x += 1
	elif direction == "backward":
		dislocationCounter += 1
		position.x -= 1
	if dislocationCounter == dislocation:
		changeDirections()
	
func _on_Timer_timeout():
	direction = "backward"
	
func changeDirections():
	dislocationCounter = 0
	if direction == "forward":
		direction = "still"
		$Timer.start()
	elif direction == "backward":
		direction = "forward"
		

func _on_Spike_body_entered(body):
	body.hurt(throwDirection)
