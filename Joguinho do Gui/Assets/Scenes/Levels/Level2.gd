extends Node2D

onready var background_music = $BackgroundMusic
onready var enable_music = false

func _process(delta):
	if enable_music:
		if not background_music.playing:
			background_music.play()
	
func _on_MusicTrigger_body_entered(body):
	enable_music = true
	if not background_music.playing:
		background_music.play()
