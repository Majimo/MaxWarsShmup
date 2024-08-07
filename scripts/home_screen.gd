extends Node2D


@onready var selector_ng = $Menu/VBoxContainer/NewGameContainer/SelectorNG
@onready var selector_hg = $Menu/VBoxContainer/HighScoresContainer/SelectorHS
@onready var ng_label = $Menu/VBoxContainer/NewGameContainer/NewGame
@onready var hs_label = $Menu/VBoxContainer/HighScoresContainer/HighScores

var menu_states := ['NEW_GAME', 'HIGH_SCORES']
var menu_state := 'NEW_GAME'

func _ready():
	set_state(menu_states[0])

func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		set_state(menu_states[1])
	elif Input.is_action_just_pressed("ui_up"):
		set_state(menu_states[0])
	
	elif Input.is_action_just_pressed("ui_accept"):
		if menu_state == menu_states[0]:
			change_scene_to_next()
		if menu_state == menu_states[1]:
			print('high score')


func change_scene_to_next():
	var launch_game = "res://scenes/main.tscn"
	var error = get_tree().change_scene_to_file(launch_game)
	
	# Vérifiez si le changement de scène s'est bien passé
	if error != OK:
		print("Erreur lors du changement de scène: ", error)

func set_state(state: String):
	menu_state = state
	match state:
		'NEW_GAME':
			selector_ng.visible = true
			selector_hg.visible = false
			hs_label.add_theme_color_override("font_color", Color(253,197,0,255))
			ng_label.add_theme_color_override("font_color", Color('#e7973a'))
		'HIGH_SCORES':
			selector_ng.visible = false
			selector_hg.visible = true
			ng_label.add_theme_color_override("font_color", Color(253,197,0,255))
			hs_label.add_theme_color_override("font_color", Color('#e7973a'))
