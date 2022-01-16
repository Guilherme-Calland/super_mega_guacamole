extends Area2D

var falling = true

func _process(delta):
	if falling:
		position.y += 1

func _on_Spike_body_entered(body):
	
	if collides_with_player(body):
		body.hurt()
	
	if collides_with_terrain(body):
		falling = false
	
func collides_with_terrain(body):
	return body.get_collision_layer() == 2
	
func collides_with_player(body):
	return body.get_collision_layer() == 1
