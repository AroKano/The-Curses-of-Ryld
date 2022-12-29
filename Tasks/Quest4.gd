extends Panel

# warning-ignore:unused_argument
func _process(delta):
	if Quests.Quest4:
		if Quests.princess_killed == 1:
			get_node("Label").text = "Quest Complete!"
		else:
# warning-ignore:standalone_expression
			get_node("TextureRect").texture
			get_node("Label").text = "Go Slay the Evil Spirit!     " + str(Quests.princess_killed) + "/1"
	else:
		get_node("Label").text = "Go find Quest!"
