extends Panel

func _process(delta):
	if Quests.Quest4:
		if Quests.princess_killed == 5:
			get_node("Label").text = "Quest Complete!"
		else:
			get_node("TextureRect").texture
			get_node("Label").text = "Go Slay 5 Red Bats!     " + str(Quests.princess_killed) + "/5"
	else:
		get_node("Label").text = "Go find Quest!"
