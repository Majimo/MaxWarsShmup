extends Timer


@onready var spawn_timer = $"."

var min_time := 1
var max_time := 4


func _ready():
	spawn_enemy()
	spawn_timer.timeout.connect(spawn_enemy)

func spawn_enemy():    
	randomize()
	wait_time = randf_range(min_time, max_time)
	start()
