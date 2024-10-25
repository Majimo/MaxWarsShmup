extends Control


@onready var first_letter = $HBoxContainer/VBoxContainer/FirstLetter
@onready var second_letter = $HBoxContainer/VBoxContainer2/SecondLetter
@onready var third_letter = $HBoxContainer/VBoxContainer3/ThirdLetter

var letter_states = ['FIRST', 'SECOND', 'THIRD']
var letter_state = 'FIRST'
var letters = ['A ', 'B ', 'C ', 'D ', 'E ', 'F ', 'G ', 'H ', 'I ', 'J ', 'K ', 'L ', 'M ', 'N ', 'O ', 'P ', 'Q ', 'R ', 'S ', 'T ', 'U ', 'V ', 'W ', 'X ', 'Y ', 'Z ']
var letter = 'A '


func _ready():
	set_letter_state(letter_state)

func _process(_delta):
	var selected_state_idx = 0
	var selected_letter_idx = 0
	if Input.is_action_just_pressed("ui_down"):
		selected_letter_idx = get_selected_letter_idx()
		if selected_letter_idx < letters.size() - 1:
			selected_letter_idx += 1
			letter = letters[selected_letter_idx]
		set_letter_in_letter_state(letter_state)
			
	elif Input.is_action_just_pressed("ui_up"):
		selected_letter_idx = get_selected_letter_idx()
		if selected_letter_idx > 0:
			selected_letter_idx -= 1
			letter = letters[selected_letter_idx]
		set_letter_in_letter_state(letter_state)
		
	elif Input.is_action_just_pressed("ui_right"):
		selected_state_idx = get_selected_letter_state_idx()
		if selected_state_idx < letter_states.size() - 1:
			selected_state_idx += 1
			set_letter_state(letter_states[selected_state_idx])
	elif Input.is_action_just_pressed("ui_left"):
		selected_state_idx = get_selected_letter_state_idx()
		if selected_state_idx > 0:
			selected_state_idx -= 1
			set_letter_state(letter_states[selected_state_idx])

	elif Input.is_action_just_pressed("ui_accept"):
		save_score()

func save_score():
	var high_scores = Globals.load_scores()
	var game_over = "res://scenes/game_over.tscn"

	if typeof(high_scores) == TYPE_DICTIONARY:
		var score_to_update = true
		for i in high_scores.scores.size():
			if score_to_update and Globals.score > high_scores.scores[i].score:
				var new_score = Globals.score
				high_scores.scores[i].score = new_score
				high_scores.scores[i].name = first_letter.text.replace(" ","") + second_letter.text.replace(" ","") + third_letter.text.replace(" ","")
				score_to_update = false
				break
		high_scores.scores.sort_custom(_compare_scores)
		Globals.update_score(high_scores)
		get_tree().change_scene_to_file(game_over)
	else:
		get_tree().change_scene_to_file(game_over)

func get_selected_letter_idx() -> int:
	match letter_state:
		'FIRST':
			letter = first_letter.text
		'SECOND':
			letter = second_letter.text
		'THIRD':
			letter = third_letter.text
	return letters.find(letter, 0)

func get_selected_letter_state_idx() -> int:
	return letter_states.find(letter_state, 0)

func set_initial_states():
	first_letter.add_theme_color_override("font_color", Color(253,197,0,255))
	second_letter.add_theme_color_override("font_color", Color(253,197,0,255))
	third_letter.add_theme_color_override("font_color", Color(253,197,0,255))

func set_letter_state(state: String):
	letter_state = state
	set_initial_states()
	match state:
		'FIRST':
			first_letter.add_theme_color_override("font_color", Color('#e7973a'))
		'SECOND':
			second_letter.add_theme_color_override("font_color", Color('#e7973a'))
		'THIRD':
			third_letter.add_theme_color_override("font_color", Color('#e7973a'))

func set_letter_in_letter_state(state: String):
	match state:
		'FIRST':
			first_letter.text = letter
		'SECOND':
			second_letter.text = letter
		'THIRD':
			third_letter.text = letter

func _compare_scores(a: Dictionary, b: Dictionary) -> int:
	return a["score"] < b["score"]
