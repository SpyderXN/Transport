extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.visible = false


func change_scene(target: String):
	animation_player.play("close")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("close")

func reload_scene():
	animation_player.play("close")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards("close")
