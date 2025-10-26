extends Node2D
class_name Main

var bullet_scene = preload("res://Bullet/bullet.tscn")
@onready var spawns: Node2D = $Spawns
@onready var count_down: Timer = $CountDown

func _ready() -> void:
	count_down.start()

func _on_player_shoot(shoot_marker_pos: Variant, player_direction: Variant) -> void:
	var bullet = bullet_scene.instantiate() as Area2D
	bullet.position = shoot_marker_pos
	bullet.direction = player_direction
	bullet.rotation_degrees = rad_to_deg(player_direction.angle()) + 90
	spawns.add_child(bullet)

func _on_enemy_fire(shoot_marker_pos: Variant, enemy_direction: Variant) -> void:
	var bullet = bullet_scene.instantiate() as Area2D
	bullet.position = shoot_marker_pos
	bullet.direction = enemy_direction
	bullet.rotation_degrees = rad_to_deg(enemy_direction.angle()) + 90
	spawns.add_child(bullet)


func _on_count_down_timeout() -> void:
	count_down.stop()
	#Transition.change_scene("res://GameOver/game_over.tscn")
	print("You Failed")
