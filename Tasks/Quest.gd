extends Panel

# warning-ignore:unused_argument
func _process(delta):
	if Quests.IntroQuest:
# warning-ignore:standalone_expression
		get_node("TextureRect").texture
		get_node("Label").text = "Go Slay 5 Bats!     " + str(Quests.bats_killed) + "/5"
	else:
		get_node("Label").text = "Talk to the NPC!"
