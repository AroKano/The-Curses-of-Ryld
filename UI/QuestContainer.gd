extends VBoxContainer

const Quest1 = preload("res://Tasks/Quest1.tscn")
const Quest2 = preload("res://Tasks/Quest2.tscn")
const Quest3 = preload("res://Tasks/Quest3.tscn")
const Quest4 = preload("res://Tasks/Quest4.tscn")


func show_Quests():
	for i in get_child_count():
		get_child(i).queue_free()
		
	if Quests.Quest1:
		var quest1 = Quest1.instance()
		self.add_child(quest1)
		
	if Quests.Quest2:
		var quest2 = Quest2.instance()
		self.add_child(quest2)
		
	if Quests.Quest3:
		var quest3 = Quest3.instance()
		self.add_child(quest3)
		
	if Quests.Quest4:
		var quest4 = Quest4.instance()
		self.add_child(quest4)
