extends Panel

# warning-ignore:unused_argument
func _process(delta):
	if Quests.Quest3:
		if Quests.bats_v2_killed == 5:
			get_node("Label").text = "Quest Complete!"
		else:
# warning-ignore:standalone_expression
			get_node("TextureRect").texture
			get_node("Label").text = "Go Slay 5 Red Bats!     " + str(Quests.bats_v2_killed) + "/5"
	else:
		get_node("Label").text = "Go find Quest!"
