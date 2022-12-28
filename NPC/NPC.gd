extends StaticBody2D

onready var dialog
var active = false
var is_quest_accepted = false
var is_quest_finished = false

func _ready():
	pass

# warning-ignore:unused_argument
func unpause (timeline_end):
	get_tree().paused = false

func _on_NPC_body_entered(body):
	if body.name == "Player":
		active = true
		if not is_quest_accepted and not is_quest_finished:
			dialog = Dialogic.start("start")
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect("dialogic_signal", self, "dialog_msg")
			dialog.connect("timeline_end", self, "unpause")
		if is_quest_accepted and not is_quest_finished:
			if Quests.bats_killed <= 5:
				Dialogic.set_variable("QuestRequirement", 1)
				dialog = Dialogic.start("check_not_finished")
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect("dialogic_signal", self, "dialog_msg")
				dialog.connect("timeline_end", self, "unpause")
			if Quests.bats_killed >= 5:
				Dialogic.set_variable("QuestRequirement", 5)
				dialog = Dialogic.start("check_finished")
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect("dialogic_signal", self, "dialog_msg")
				dialog.connect("timeline_end", self, "unpause")
		if is_quest_accepted and is_quest_finished:
				dialog = Dialogic.start("finish")
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect("dialogic_signal", self, "dialog_msg")
				dialog.connect("timeline_end", self, "unpause")
		if dialog != null and is_instance_valid(dialog):
			add_child(dialog)
			get_tree().paused = true
		
func dialog_msg(string):
	match string:
		"yes":
			is_quest_accepted = true
			is_quest_finished = false
			Quests.IntroQuest = true
		"no":
			is_quest_accepted = false
			is_quest_finished = false
			Quests.IntroQuest = false
		"yes_not_finished":
			is_quest_accepted = true
			is_quest_finished = false
		"no_not_finished":
			is_quest_accepted = true
			is_quest_finished = false
		"yes_finished":
			is_quest_accepted = true
			is_quest_finished = true
		"no_finished":
			is_quest_accepted = true
			is_quest_finished = false

func _on_NPC_body_exited(body):
	if body.name == "Player":
		active = false
