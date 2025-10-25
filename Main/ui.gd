extends CanvasLayer

@onready var timer: Label = $Timer
@onready var count_down: Timer = $"../CountDown"

func _process(_delta: float) -> void:
	show_count_down()

func show_count_down():
	timer.text = "Time left: " + str(int(count_down.time_left))
