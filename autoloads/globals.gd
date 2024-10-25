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
	var file = FileAccess.open("res://high_scores.json", FileAccess.READ)
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

func update_score(newName: String, new_score: int):
	var data = load_scores()
	if data.empty():
		print("Erreur : le fichier JSON est vide ou introuvable.")
		return
	
	for score_entry in data["scores"]:
		if score_entry["name"] == newName:
			score_entry["score"] = new_score
			break  # Sort de la boucle une fois l'entrée modifiée
	
	save_scores(data)

func save_scores(data):
	var file = FileAccess.open("res://high_scores.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
