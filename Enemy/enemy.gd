extends CharacterBody2D
class_name Enemy

@onready var shoot_timer: Timer = $ShootTimer
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var marker_2d: Marker2D = $Marker2D

#@export var bullet_scene = preload("res://Bullet/bullet.tscn")
@export var speed: float = 50
@export var shoot_range: float = 300
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2

var player: Node2D
var can_shoot = true
var hit = false

signal fire(shoot_marker_pos, enemy_direction)

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	ray_cast.target_position = Vector2.UP * shoot_range
	sprite_2d.visible = true
	sprite_2d_2.visible = false

func _physics_process(_delta: float) -> void:
	if not player:
		return
	
	var direction = (player.global_position - global_position).normalized()
	
	if hit == false:
		look_at(player.global_position)
		rotation += deg_to_rad(90)
	
	ray_cast.force_raycast_update()

	if ray_cast.is_colliding() and can_shoot:
		var collider = ray_cast.get_collider()
		if collider.is_in_group("Player"):
			can_shoot = false
			shoot_timer.start()
			var shoot_marker_pos = marker_2d.global_position
			var enemy_direction = (player.global_position - position).normalized()
			fire.emit(shoot_marker_pos, enemy_direction)

	velocity = direction * speed
	move_and_slide()
	
	if hit != false:
		sprite_2d.visible = false
		sprite_2d_2.visible = true
		can_shoot = false
		shoot_timer.stop()
		var tween = get_tree().create_tween()
		tween.tween_property($".", "speed", 0, 1)

#func _shoot() -> void:
	#print("Shoot function called")
	#var bullet = bullet_scene.instantiate()
	#print("Bullet created:", bullet)
	#bullet.global_position = marker_2d.global_position
	## Fix rotation so bullet moves toward player
	#var dir_to_player = (player.global_position - position).normalized()
	#bullet.rotation_degrees = rad_to_deg(dir_to_player.angle()) + 90 
	#get_tree().current_scene.add_child(bullet)
	#print("Bullet added to scene")

func _on_shoot_timer_timeout() -> void:
	can_shoot = true


func _on_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		print("Enemy hit")
		hit = true
