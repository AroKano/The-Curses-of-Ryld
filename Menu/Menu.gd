extends Control

func _ready():
	$Menu/StartBTN.grab_focus()

func _on_StartBTN_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World.tscn")
	
func _on_QuitBTN_pressed():
	get_tree().quit()
