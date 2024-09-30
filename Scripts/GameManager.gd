extends Node

func reset():
	pass

func load_next_level(next_scene: String):
	get_tree().call_deferred("change_scene_to_file", next_scene)
	
func load_same_level():
	get_tree().call_deferred("reload_current_scene")
