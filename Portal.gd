tool

extends Area2D

export(String, FILE) var next_scene_path = ""
export(Vector2) var player_spawn_location = Vector2.ZERO
export(int) var Player_direction = 1

func _get_configuration_warning() -> String:
	if next_scene_path == "":
		return "next_scene_path must be set for the portal to work"
	else:
		return ""


func _on_Portal_body_entered(body):
	Global.player_initial_map_position = player_spawn_location
	Global.player_facing_direction = Player_direction
	if get_tree().change_scene(next_scene_path) != OK:
		#error handling here
		print("unavailable scene!")
