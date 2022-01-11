extends Node2D

func _on_HandRight_body_entered(body):
	body.move_right()

func _on_HandLeft_body_entered(body):
	body.move_left()
