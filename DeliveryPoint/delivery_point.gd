extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Transition.change_scene("res://WinScreen/win_screen.tscn")
