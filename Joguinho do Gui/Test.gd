extends Node2D

func _physics_process(delta):
	if Input.is_action_pressed("push"):
		$Sprite.play("push")
	else:
		$Sprite.play("idle")
