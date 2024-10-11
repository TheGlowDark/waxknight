extends Node


var player: Player
var config = ConfigFile.new()

func reset():
	load_same_level()

func load_next_level(next_scene: String):
	get_tree().call_deferred("change_scene_to_file", next_scene)

func load_same_level():
	get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")

func save_game():
	player = get_tree().current_scene.get_child(0)
	config.set_value("Player", "x", round(player.global_position.x))
	config.set_value("Player", "y", round(player.global_position.y))
	config.save("res://savefile.cfg")

func load_game():
	load_same_level()
	await get_tree().process_frame
	player = get_tree().current_scene.get_child(0)
	var save_file = config.load("res://savefile.cfg")
	if save_file == OK:
		player.global_position.x = config.get_value("Player", "x")
		player.global_position.y = config.get_value("Player", "y")
		player.health = 3
		player.sprite.self_modulate.a = 255
