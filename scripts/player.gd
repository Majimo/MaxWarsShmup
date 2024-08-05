extends CharacterBody2D


var bullet = preload("res://scenes/player_bullet.tscn")

@export var speed := 400
@export var sprite_half_size := 64
@export var health := 6	# On double les points de vie du joueur pour être sûr qu'il perde "une vie" quand il se fait toucher par les 2 tirs

@onready var up_spawn = $SpawnUp
@onready var down_spawn = $SpawnDown

var can_shoot := true


func _process(_delta):
	if can_shoot and Input.is_action_pressed("ui_accept"):
		shoot()

func _physics_process(_delta):
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = velocity.normalized() * speed
	move_and_slide()
	global_position.x = clamp(global_position.x, sprite_half_size, get_viewport().size.x - sprite_half_size)
	global_position.y = clamp(global_position.y, sprite_half_size, get_viewport().size.y - sprite_half_size)


func _on_shooting_timer_timeout():
	can_shoot = true


func shoot():
	can_shoot = false
	$ShootingTimer.start()
	
	# Pas trouvé mieux que de l'instancier deux fois... :/
	var bullet_instance = bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.position = up_spawn.global_position
	
	var bullet_instance2 = bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance2)
	bullet_instance2.position = down_spawn.global_position

func player_hit():
	health -= 1
	Globals.health = int(health / 2)
	if health <= 0:
		queue_free()
		print('player dead')
