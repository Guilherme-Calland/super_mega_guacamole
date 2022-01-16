extends Area2D

export var boostForce = 650

func _on_JumpPad_body_entered(body):
	$AnimatedSprite.play("boost")
	body.boost(boostForce)
	$Timer.start()

func _on_Timer_timeout():
	$AnimatedSprite.play("idle")
