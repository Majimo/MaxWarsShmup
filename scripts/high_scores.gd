extends Node2D


@onready var first_label = $VBoxContainer/VBoxContainer/FisrContainer/FirstLabel
@onready var first_score = $VBoxContainer/VBoxContainer/FisrContainer/FirstScore
@onready var second_label = $VBoxContainer/VBoxContainer/SecondContainer/SecondLabel
@onready var second_score = $VBoxContainer/VBoxContainer/SecondContainer/SecondScore
@onready var third_label = $VBoxContainer/VBoxContainer/ThirdContainer/ThirdLabel
@onready var third_score = $VBoxContainer/VBoxContainer/ThirdContainer/ThirdScore


var data_to_send = {
	"scores": [
		{"name": "AAA", "score": "10"}, 
		{"name": "BBB", "score": "20"}, 
		{"name": "CCC", "score": "30"}
		]
	}
var json_string = JSON.stringify(data_to_send)

var json = JSON.new()
var parsed_json = json.parse(json_string)

var input_disabled = true


func _ready():
	input_disabled = true
	var timer = Timer.new()
	timer.wait_time = 0.5  # Temps à attendre (en secondes) avant de réactiver les entrées
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

	if parsed_json == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			for i in data_to_send.scores.size():
				if i == 0:
					first_label.text = data_to_send.scores[i].name + ' '
					first_score.text = data_to_send.scores[i].score
				elif i == 1:
					second_label.text = data_to_send.scores[i].name + ' '
					second_score.text = data_to_send.scores[i].score
				elif i == 2:
					third_label.text = data_to_send.scores[i].name + ' '
					third_score.text = data_to_send.scores[i].score
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())


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
