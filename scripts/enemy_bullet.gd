extends Area2D


@export var speed := 800


func _physics_process(_delta):
	position.x -= speed * get_physics_process_delta_time()
	
	if global_position.x > (2 * get_viewport().size.y):
		queue_free()
