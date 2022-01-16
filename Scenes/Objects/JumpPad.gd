extends Area2D

export var boostForce = 650

func _on_JumpPad_body_entered(body):
	$JumpPadSprite.play("boost")
	$Timer.start()
	body.boost(boostForce)

func _on_Timer_timeout():
	$JumpPadSprite.play("idle")
