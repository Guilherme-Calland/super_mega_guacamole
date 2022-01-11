extends Area2D

export var boost = 1.6

func _on_JumpPad_body_entered(body):
	$AnimationPlayer.play("boost")
	body.boost(boost)
