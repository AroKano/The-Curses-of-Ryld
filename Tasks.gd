extends CanvasLayer

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Tab"):
		var newPauseState: bool = !get_tree().paused
		get_tree().paused = newPauseState
		if (newPauseState):
			show()
		else:
			hide()

