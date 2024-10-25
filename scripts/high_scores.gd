extends Node2D


@onready var first_label = $VBoxContainer/VBoxContainer/FisrContainer/FirstLabel
@onready var first_score = $VBoxContainer/VBoxContainer/FisrContainer/FirstScore
@onready var second_label = $VBoxContainer/VBoxContainer/SecondContainer/SecondLabel
@onready var second_score = $VBoxContainer/VBoxContainer/SecondContainer/SecondScore
@onready var third_label = $VBoxContainer/VBoxContainer/ThirdContainer/ThirdLabel
@onready var third_score = $VBoxContainer/VBoxContainer/ThirdContainer/ThirdScore

var input_disabled = true


func _ready():
	input_disabled = true
	var timer = Timer.new()
	timer.wait_time = 0.5  # Temps à attendre (en secondes) avant de réactiver les entrées
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

	var data_received = Globals.load_scores()
	if typeof(data_received) == TYPE_DICTIONARY:
		for i in data_received.scores.size():
			if i == 0:
				first_label.text = data_received.scores[i].name + ' '
				first_score.text = str(data_received.scores[i].score)
			elif i == 1:
				second_label.text = data_received.scores[i].name + ' '
				second_score.text = str(data_received.scores[i].score)
			elif i == 2:
				third_label.text = data_received.scores[i].name + ' '
				third_score.text = str(data_received.scores[i].score)
	else:
		print("Unexpected data")


func _process(_delta):
	var home_screen = "res://scenes/home_screen.tscn"
	if input_disabled:
		return
	if Input.is_anything_pressed() and not input_disabled:
		get_tree().change_scene_to_file(home_screen)
		input_disabled = true
	if not Input.is_anything_pressed():
		input_disabled = false

func _on_timer_timeout():
	input_disabled = false
