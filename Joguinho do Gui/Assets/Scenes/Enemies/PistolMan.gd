extends KinematicBody2D

onready var top_collision = $ChildNode/Top/TopCollisionShape
onready var side_collision = $ChildNode/Sides/SIdesCollisionShape
onready var sprite = $ChildNode/AnimatedSprite
onready var spike_hat_collision = $HatSpikes/HatSpikeCollisionShape
onready var sight_ray = $RayCast2D
onready var shoot_timer = $Timer
onready var move_timer = $MoveTimer
onready var head_sprite = $ChildNode/Head/AnimatedSprite

export var reload_time = 0.75
export var spike_hat_on = false
export var ray_length = 240
export var has_a_gun = true

var smoosh_audio = "res://Assets/SFX/esmagando.ogg"
var shoot_audio = "res://Assets/SFX/shooting_sound.ogg"
var falling_audio = "res://Assets/SFX/falling.ogg"

var bullet_timeout = false
var dead = false
var first_encounter = true
var top_collision_lock = false

var motion = Vector2(0,0)
const GRAVITY = 10
const UP = Vector2(0, -1)

func _process(delta):
	shoot_timer.wait_time = reload_time
	
	if not is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = 0
		
	if position.y > 180:
		if not dead:
			play_audio2D(falling_audio)
			dead = true
		elif position.y > 10000:
			queue_free()
			
	
	move_and_slide(motion, UP)
	if not dead:
		if sight_ray.is_colliding() and has_a_gun:
			sight_ray.cast_to = Vector2(-ray_length, 0)
			if spike_hat_on:
				sprite.play("pointing_gun_w_spike_hat")
				put_on_spike_hat()
			else:
				sprite.play("pointing_gun")
				remove_spike_hat()
			fire()
		else:
			first_encounter = true
			if spike_hat_on:
				sprite.play("ready_w_spike_hat")
				put_on_spike_hat()
			else:
				sprite.play("ready")
				remove_spike_hat()
		
	if first_encounter:
		shoot_timer.start()
		first_encounter = false
		bullet_timeout = false

func play_animation(animation):
	$ChildNode/AnimationPlayer.play(animation)

func fire():
	if bullet_timeout:
		instanciate_bullet()
		play_audio(shoot_audio)
		bullet_timeout = false
		shoot_timer.start()
		pass

func get_shot():
	head_sprite.play("splatter")
	sprite.play("headshot")
	die()
	
func _on_Top_body_entered(body):
	body.smoosh()
	die()
	sprite.play("smooshed")

func _on_Sides_body_entered(body):
	disable_top_collision()
	top_collision_lock = true
	play_animation("unlock_top_collision")
	body.hurt()

func instanciate_bullet():
	var bullet = load("res://Assets/Scenes/Enemies/Bullet.tscn").instance()
	sight_ray.add_child(bullet)

func disable_top_collision():
	top_collision.set_deferred("disabled", true)

func disable_side_collision():
	side_collision.set_deferred("disabled", true)

func enable_top_collision():
	top_collision.set_deferred("disabled", false)

func unlock_top_collision():
	top_collision_lock = false

func remove_spike_hat():
	spike_hat_collision.set_deferred("disabled", true)
	if not top_collision_lock:
		enable_top_collision()
	
func put_on_spike_hat():
	spike_hat_collision.set_deferred("disabled", false)
	disable_top_collision()
	
func die():
	spike_hat_collision.set_deferred("disabled", true)
	disable_side_collision()
	disable_top_collision()
	play_animation("die")
	play_audio(smoosh_audio)
	dead = true

func disapear():
	queue_free()

func play_audio(audio):
	$SoundEffects.stream = load(audio)  
	$SoundEffects.play()

func play_audio2D(audio2D):
	$SoundEffects2D.stream = load(audio2D)
	$SoundEffects2D.play()

func _on_Timer_timeout():
	bullet_timeout = true

func _on_HatSpikes_body_entered(body):
	body.hurt()

func move_left():
	if not dead:
		move_timer.start()
		motion.x = -200

func move_right():
	if not dead:
		move_timer.start()
		motion.x = 200

func _on_MoveTimer_timeout():
	motion.x = 0

