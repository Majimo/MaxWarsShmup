extends CharacterBody2D

var bullet = preload("res://scenes/enemy_bullet.tscn")

@export var speed := 400

@onready var up_spawn = $SpawnUp
@onready var down_spawn = $SpwanDown

var can_shoot := true
var player = null


func _physics_process(delta):
	var movement = Vector2(-2, 0)
	if player:
		movement = position.direction_to(player.position)
	
	movement = movement.normalized() * speed
	move_and_collide(movement * delta)


func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_shooting_timer_timeout():
	can_shoot = true
	if player != null:
		shoot()


func shoot():
	print('shoot', can_shoot)
	if can_shoot:
		# Pas trouvé mieux que de l'instancier deux fois... :/
		var bullet_instance = bullet.instantiate()
		get_parent().add_child(bullet_instance)
		bullet_instance.position = up_spawn.global_position
		
		var bullet_instance2 = bullet.instantiate()
		get_parent().add_child(bullet_instance2)
		bullet_instance2.position = down_spawn.global_position
		
		$ShootingTimer.start()
		can_shoot = false
		print('shoot in loop', can_shoot)
