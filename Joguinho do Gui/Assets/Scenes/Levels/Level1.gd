extends Node2D

var melody = "res://Assets/SFX/melody.ogg"
var townTheme = "res://Assets/SFX/TownTheme.ogg"
var crossed_threshold = false

onready var tune = $Music/BackgroundMusic

export var enable_music = false
export var music_only_after_threshold = true

func _ready():
	tune.stream = load(townTheme)

func _process(delta):
	if not enable_music:
		tune.stop()
	else:
		if music_only_after_threshold:
			if crossed_threshold:
				play_tune()
		else:
			play_tune()

func _on_MusicSeparatorStart_body_entered(body):
	crossed_threshold = true
	play_tune()
	
func play_tune():
	if enable_music:
		if not tune.playing:
			tune.play()

func stop_tune():
	tune.stop()

func _on_MusicSeparatorEnd_body_entered(body):
	body.enable_sound_effects()

func _on_Door_body_entered(body):
	get_tree().change_scene("res://Assets/Scenes/Levels/Level2.tscn")
