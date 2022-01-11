extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 100
const GRAVITY = 10
const UP = Vector2(0, -1)
const JUMP_SPEED = 300
const WORLD_LIMIT = 700

export var lives = 10
export var enable_sound_effects = true

var jump_audio = "res://Assets/SFX/pulando.ogg"
var hurt_audio = "res://Assets/SFX/machucou.ogg"
var background_music = "res://Assets/SFX/background_piano_melody.ogg"
var impulso = "res://Assets/SFX/impulso.ogg"
onready var sprite = $PlayerAnimation
onready var throw_timer = $Timers/ThrowTimer
onready var right_hand = $Hands/HandRight/CollisionShape2D
onready var left_hand = $Hands/HandLeft/CollisionShape2D

var hurting = false
var ducking = false
var pushing = false
var facing_right = true
var dragged = false
var drag_speed = 0.0

func _physics_process(delta):
	apply_gravity()
	define_movement()
	animate()
	define_mortality()

func define_mortality():
	get_tree().call_group("GUI", "set_lives", lives)
	if motion.y > 0 and is_on_floor():
		hurting = false
	if motion.y > 1000:
		end_game()

func boost(boost_multiplier):
	setVerticalVelocity(-JUMP_SPEED * boost_multiplier)
	play_audio(impulso)

func end_game():
	get_tree().change_scene("res://Assets/Scenes/Levels/EndGame.tscn")

func apply_gravity():
	if not is_on_floor():
		setVerticalVelocity(motion.y + GRAVITY)
	elif motion.y > 0:
		setVerticalVelocity(0)
	
	if is_on_ceiling():
		setVerticalVelocity(GRAVITY)
		
	if is_on_floor():
		hurting = false
	
func key_pressed(key):
	return Input.is_action_pressed(key)

func setHorizontalVelocity(x):
	motion.x = x

func setVerticalVelocity(y):
	motion.y = y

func define_movement():
	if not dragged:
		if key_pressed("left") and not key_pressed("right"):
			setHorizontalVelocity(-SPEED)
		elif key_pressed("right") and not key_pressed("left"):
			setHorizontalVelocity(SPEED)
		else:
			setHorizontalVelocity(0)
	else:
		if key_pressed("left") and not key_pressed("right"):
			setHorizontalVelocity(drag_speed - SPEED)
		elif key_pressed("right") and not key_pressed("left"):
			setHorizontalVelocity(drag_speed + SPEED)
		else:
			setHorizontalVelocity(drag_speed)
		
	#jumping
	if key_pressed("jump") and is_on_floor():
		play_audio(jump_audio)
		jump()
	move_and_slide(motion, UP)

func jump():
	setVerticalVelocity(-JUMP_SPEED)

func play_audio(audio):
	if enable_sound_effects:
		$SoundEffects.stream = load(audio)  
		$SoundEffects.play()

func play_animation(animation):
	sprite.play(animation)

func animate():
	if motion.x > 0:
		sprite.flip_h = false
		facing_right = true
	elif motion.x < 0:
		sprite.flip_h = true
		facing_right = false
	
	if hurting:
		play_animation("hurt")
	elif motion.y < 0 or motion.y > 11:
		play_animation("jump")
	elif is_on_floor():
		if key_pressed("down"):
			ducking = true
		else:
			ducking = false
			if key_pressed("action"):
				if facing_right:
					right_hand.disabled = false
				else:
					left_hand.disabled = false
				pushing = true
			else:
				right_hand.disabled = true
				left_hand.disabled = true
				pushing = false
				
		var temp_speed = 0.0
		if not dragged:
			temp_speed = 0
		else: temp_speed = drag_speed
		
		if motion.x != temp_speed:
			if not ducking:
				if not pushing:
					play_animation("walk")
				else:
					play_animation("push_walk")
			else:
				play_animation("duck_walk")
		else:
			if not ducking:
				if not pushing:
					play_animation("idle")
				else:
					play_animation("push")
			else:
				play_animation("duck")

func hurt():
	hurting = true
	jump()
	play_animation("hurt")
	play_audio(hurt_audio)
	lives -= 1
	get_tree().call_group("GUI", "set_lives", lives)
	if lives < 0:
		end_game()

func smoosh():
	jump()

func disable_sound_effects():
	enable_sound_effects = false

func enable_sound_effects():
	enable_sound_effects = true

func drag(speed):
	dragged = true
	drag_speed = speed
	setHorizontalVelocity(speed)

func stop_dragging():
	dragged = false

