extends Node2D

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

func _ready():
	if parsed_json == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			for i in data_to_send.scores:
				print(i.name, " => ", i.score)
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
