extends Node2D


@onready var parallax_background = $ParallaxBackground
@onready var parallax_first = $ParallaxBackground/First
@onready var parallax_second = $ParallaxBackground/Second

var enemy = preload("res://scenes/enemy.tscn")


func _ready():
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = Vector2(1252, randi_range(100, 548))
	get_tree().current_scene.add_child(enemy_instance)

func _process(delta):
	# Display a parallax background
	parallax_background.position.x -= delta * 175
	if parallax_first.global_position.x < -1300:
		parallax_first.global_position.x = 1299
	if parallax_second.global_position.x < -1300:
		parallax_second.global_position.x = 1299


func _on_enemy_spawn_timer_timeout():
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = Vector2(1252, randi_range(100, 548))
	get_tree().current_scene.add_child(enemy_instance)
