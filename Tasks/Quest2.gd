extends Panel

func _process(delta):
	if Quests.Quest2:
		if Quests.bats_killed == 5:
			get_node("Label").text = "Quest Complete!"
		else:
			get_node("TextureRect").texture
			get_node("Label").text = "Go Slay 5 Bats!     " + str(Quests.bats_killed) + "/5"
	else:
		get_node("Label").text = "Go find Quest!"
