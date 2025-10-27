extends Area2D

@export var speed = 0
var direction = Vector2.UP
@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera")

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		camera.trigger_shake()
		print(body.name)
		queue_free()
	elif body.is_in_group("Enemy"):
		camera.trigger_shake()
		print(body.name)
		queue_free()
	elif body.is_in_group("Obstacles"):
		print(body.name)
		queue_free()
	elif body.is_in_group("Walls"):
		print(body.name)
		queue_free()
