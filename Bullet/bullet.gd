extends Area2D

@export var speed = 0
var direction = Vector2.UP

func _process(delta: float) -> void:
	position += direction * speed * delta
