extends Area2D

export var throwDirection = Vector2(-100, -500)

func _on_Spike_body_entered(body):
	if collides_with_player(body):
		body.hurt(throwDirection)
	
func collides_with_terrain(body):
	return body.get_collision_layer() == 2
	
func collides_with_player(body):
	return body.get_collision_layer() == 1
