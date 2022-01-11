extends Node2D

export var bullet_speed = 300

func _process(delta):
	position.x -= bullet_speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_collision_layer() == 1:
		if not body.ducking:
			queue_free()
			body.hurt()
	else:
		queue_free()

func _on_Area2D_area_entered(area):
	if area.get_collision_layer() == 16:
		area.get_parent().get_parent().get_shot()
		$Area2D/Sprite.play("bloody")
