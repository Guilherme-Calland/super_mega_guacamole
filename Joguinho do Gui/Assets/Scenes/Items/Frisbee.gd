extends KinematicBody2D

const UP = Vector2(0, -1)

export var direction = Vector2(0,0)
export var gravity = 0.0
export var wind_resistance = 0.0
export var player_collision = false

onready var collision = $PlayerRigidBody/PlayerCollision
onready var drag_trigger = $Area2D/DragTrigger

func _process(delta):
	move_and_slide(direction, UP)
	if direction.x != 0:
		direction.x -= wind_resistance
	direction.y += gravity
	if player_collision:
		collision.set_deferred("disabled", false)
		drag_trigger.set_deferred("disabled", false)
	else:
		collision.set_deferred("disabled", true)
		drag_trigger.set_deferred("disabled", true)

func _on_Area2D_area_entered(area):
	area.get_parent().drag(direction.x)

func _on_Area2D_area_exited(area):
	area.get_parent().stop_dragging()
