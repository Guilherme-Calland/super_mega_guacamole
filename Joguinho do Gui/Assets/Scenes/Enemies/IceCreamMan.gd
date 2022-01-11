extends KinematicBody2D

var motion = Vector2(0,0)
var dead = false
var throw_timeout = true
var first_encounter = true

const GRAVITY = 10
const UP = Vector2(0, -1)

onready var throw_timer = $ThrowTimer
onready var move_timer = $MoveTimer
onready var disapear_timer = $DisapearTimer
onready var top_collision_timer = $TopCollisionTimer

onready var popsicle_spawn = $PositionNode/PopsicleSpawn
onready var top_collision = $PositionNode/Top/TopCollisionShape
onready var side_collision = $PositionNode/Side/SideCollisionShape
onready var sprite = $PositionNode/AnimatedSprite

onready var eyesight = $PositionNode/PopsicleRayCast
onready var eyesight_looking_up = $PositionNode/PopsicleRayCastUp
onready var eyesight_looking_down = $PositionNode/PopsicleRayCastDown

onready var falling_audio = "res://Assets/SFX/falling.ogg"
onready var smoosh_audio = "res://Assets/SFX/esmagando.ogg"

export var wait_time = 2

func _process(delta):
	throw_timer.wait_time = wait_time
	if not dead:
		if eyesight.is_colliding() or eyesight_looking_up.is_colliding() or eyesight_looking_down.is_colliding():
			if throw_timer.is_stopped():
				throw_timer.start()
			sprite.play("throwing")
			if throw_timeout:
				throw_timeout = false
				instanciate_popsicle()
		else:
			sprite.play("popsicled")
	
	laws_of_gravity()
	move_and_slide(motion, UP)

func laws_of_gravity():
	if not is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = 0
		
	if motion.y > 500:
		if not dead:
			play_audio2D(falling_audio)
			dead = true
			disapear_timer.start()

func die():
	disable_top_collision()
	disable_side_collision()
	play_audio(smoosh_audio)
	disapear_timer.start()
	dead = true

func disable_top_collision():
	top_collision.set_deferred("disabled", true)

func enable_top_collision():
	top_collision.set_deferred("disabled", false)
	
func disable_side_collision():
	side_collision.set_deferred("disabled", true)

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
	
func play_audio2D(audio):
	$SoundEffects2D.stream = load(audio)
	$SoundEffects2D.play()
	
func play_audio(audio):
	$SoundEffects.stream = load(audio)
	$SoundEffects.play()

func _on_Top_body_entered(body):
	body.smoosh()
	die()
	sprite.play("smooshed")

func _on_DisapearTimer_timeout():
	queue_free()

func _on_Side_body_entered(body):
	disable_top_collision()
	top_collision_timer.start()
	body.hurt()

func _on_TopCollisionTimer_timeout():
	if not dead:
		enable_top_collision()	

func instanciate_popsicle():
	var popsicle = load("res://Assets/Scenes/Enemies/Popsicle.tscn").instance()
	popsicle_spawn.add_child(popsicle)
	
func _on_AttackArea_body_exited(body):
	sprite.play("idle")

func _on_ThrowTimer_timeout():
	throw_timeout = true
