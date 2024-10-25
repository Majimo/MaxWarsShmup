extends Timer


@onready var spawn_timer = $"."

var min_time := 1.0
var max_time := 4.0
var min_limit := 0.25  # Limite minimum pour le temps de spawn
var decrease_step := 0.2  # Montant de réduction tous les X points


func _ready():
	spawn_enemy()
	spawn_timer.timeout.connect(spawn_enemy)

func spawn_enemy():    
	randomize()
	wait_time = randf_range(min_time, max_time)
	_adjust_spawn_time(Globals.score)
	start()

func _adjust_spawn_time(score: int):
	# Calcule combien de fois le score dépasse un multiple de 25
	var levels = floor(score / 25.0)
	
	# Diminue min_time et max_time en fonction du niveau atteint
	min_time = max(min_time - levels * decrease_step, min_limit)
	max_time = max(max_time - levels * decrease_step, min_limit)
