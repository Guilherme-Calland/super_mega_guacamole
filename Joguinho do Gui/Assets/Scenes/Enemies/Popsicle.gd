extends KinematicBody2D

var direction = Vector2(-120,-200)
const UP = Vector2(0, -1)
const GRAVITY = 5

func _process(delta):
	move_and_slide(direction, UP)
	direction.y += GRAVITY

func _on_Area2D_area_entered(area):
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_collision_layer() == 1:
		body.hurt()
	queue_free()
