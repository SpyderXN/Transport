extends CharacterBody2D

@export var speed: float = 100
@export var accelaration: float = 100
@export var friction: float = 100

var can_shoot = true

@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_marker: Marker2D = $ShootMarker

signal shoot(shoot_marker_pos, player_direction)

func _process(delta: float) -> void:
	
	#Movement input
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	input_vector.y = Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * speed, accelaration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
	
	#This is for the player to look for the mouse position
	look_at(get_global_mouse_position())
	
	#Shooting input
	if Input.is_action_just_pressed("SHOOT") and can_shoot:
		can_shoot = false
		shoot_timer.start()
		var shoot_marker_pos = shoot_marker.global_position
		var player_direction = (get_global_mouse_position() - position).normalized()
		shoot.emit(shoot_marker_pos, player_direction)

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
