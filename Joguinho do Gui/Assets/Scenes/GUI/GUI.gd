extends CanvasLayer

onready var lives_label = $Control/HBoxContainer/LifeCount

func set_lives(lives):
	lives_label.text = str(lives)
