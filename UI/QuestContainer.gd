extends VBoxContainer

const IntroQuest = preload("res://Tasks/Quest.tscn")


func _ready():
	if get_child_count() == 0:
		var quest1 = IntroQuest.instance()
		self.add_child(quest1)
