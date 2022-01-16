extends Area2D

export var boostForce = 650

func _on_JumpPad_body_entered(body):
	body.boost(boostForce)
