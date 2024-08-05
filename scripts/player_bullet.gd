extends Area2D


@export var speed := 800


func _physics_process(_delta):
	position.x += speed * get_physics_process_delta_time()
	
	if global_position.x > (2 * get_viewport().size.y):
		queue_free()


func _on_body_entered(body):
	if body.has_method("enemy_hit"):
		body.enemy_hit()
		queue_free()
