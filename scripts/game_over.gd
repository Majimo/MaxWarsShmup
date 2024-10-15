extends Node2D


@onready var score_label = $ScoreContainer/ScoreLabel

var wait_time_finished := false


func _ready():
	score_label.text = String(str(Globals.score))

func _process(_delta):
	var home_screen = "res://scenes/home_screen.tscn"
	if wait_time_finished:
		if Input.is_anything_pressed():
			get_tree().change_scene_to_file(home_screen)
  

func _on_wait_to_see_screen_timeout():
	wait_time_finished = true
