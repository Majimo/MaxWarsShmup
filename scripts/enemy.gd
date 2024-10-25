extends CharacterBody2D

var bullet = preload("res://scenes/enemy_bullet.tscn")

@export var speed := 400
@export var health := 1

@onready var up_spawn = $SpawnUp
@onready var down_spawn = $SpwanDown

var can_shoot := true
var player = null
var sounds = [
	"res://sounds/tie_fighter/tie00.mp3",
	"res://sounds/tie_fighter/tie01.mp3",
	"res://sounds/tie_fighter/tie02.mp3",
	"res://sounds/tie_fighter/tie03.mp3"
]


func _ready():
	var enemy = AudioStreamPlayer2D.new()
	add_child(enemy)
	
	var sound_idx = randi_range(0, 3)
	enemy.stream = load(sounds[sound_idx])
	enemy.set_volume_db(-2)
	enemy.play()

func _physics_process(delta):
	var movement = Vector2(-2, 0)
	if is_instance_valid(player):
		movement = position.direction_to(player.position)
	else:
		player = null
		movement = Vector2(-2, 0)
	
	movement = movement.normalized() * speed
	move_and_collide(movement * delta)


func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_collision_area_body_entered(body):
	if body.has_method("player_hit"):
		print("collision avec le player")
		body.player_hit()

func _on_shooting_timer_timeout():
	can_shoot = true
	if player != null:
		shoot()


func shoot():
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

func enemy_hit():
	health -=1
	if health <= 0:
		Globals.score += 5
		print("boom")
		queue_free()
		
#		Ca marche pas pour le moment :'(
#		$CollisionArea/CollisionAreaShape2D.disabled = true
#		$CollisionShape2D2.disabled = true
#		$Sprite2D.visible = false
#
#		var explosion = $AnimatedSprite2D
#		explosion.visible = true
#		explosion.play("explode")
#		print(explosion.get_frame() == 3)
#		if explosion.get_frame() == 3:
#			print("boom")
#			queue_free()
