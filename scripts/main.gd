extends Node2D

var enemy = preload("res://scenes/enemy.tscn")


func _on_enemy_spawn_timer_timeout():
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = Vector2(get_viewport().size.x + 100, randi_range(100, get_viewport().size.y - 100))
	get_tree().current_scene.add_child(enemy_instance)
