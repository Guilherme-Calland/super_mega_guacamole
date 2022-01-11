extends Node2D

onready var throw_timer = $ThrowTimer
onready var sprite = $AnimatedSprite
onready var frisbee_spawn = $FrisbeeSpawn

export var frisbee_direction = Vector2(0, 0)
export var frisbee_gravity = 0.0
export var frisbee_wind_resistance = 0.0
export var player_collision = false
export var throw_player = false

func _on_ThrowTimer_timeout():
	sprite.play("throwing")
	instanciate_frisbee()
	
func instanciate_frisbee():
	var frisbee = load("res://Assets/Scenes/Items/Frisbee.tscn").instance()
	frisbee.direction = frisbee_direction
	frisbee.gravity = frisbee_gravity
	frisbee.wind_resistance = frisbee_wind_resistance
	frisbee.player_collision = player_collision
	frisbee_spawn.add_child(frisbee)
	
func catch():
	sprite.play("holding")
	throw_timer.start()

func _on_BeachBuddy_body_entered(body):
	catch()
	body.queue_free()



