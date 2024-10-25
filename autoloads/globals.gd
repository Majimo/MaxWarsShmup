extends Node


var health := 3
var score := 0

const SCORE_FILE_PATH := "res://high_scores.json"

# func save_initial_scores():
# 	var data = {
# 		"scores": [
# 			{"name": "AAA", "score": 10},
# 			{"name": "BBB", "score": 20},
# 			{"name": "CCC", "score": 30}
# 		]
# 	}
	
# 	var file = FileAccess.open(SCORE_FILE_PATH, FileAccess.WRITE)
# 	if file:
# 		file.store_string(JSON.stringify(data))
# 		file.close()

func load_scores():
	var file = FileAccess.open(SCORE_FILE_PATH, FileAccess.READ)
	var data_received
	if file:
		var content = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse(content)
		if parse_result == OK:
			data_received = json.data
		else:
			print("Erreur : Impossible de parser le fichier JSON.")
		file.close()
	return data_received

func update_score(new_high_scores: Dictionary):
	var data = load_scores()
	if data:
		save_scores(new_high_scores)

	else:
		print("Erreur : le fichier JSON est vide ou introuvable.")
		return

func save_scores(data):
	var file = FileAccess.open(SCORE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
