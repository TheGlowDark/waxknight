extends Node


var player: Player
var cutscene_playing := false

func reset():
	load_same_level()

func load_next_level(next_scene: String):
	get_tree().call_deferred("change_scene_to_file", next_scene)

func load_same_level():
	get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")

func save(position: Vector2):
	var save_dict = {
		"x": position.x + 20,
		"y": position.y - 16,
	}
	return save_dict

func save_game(position: Vector2):
	print("saved the game")
	var save_game_file = FileAccess.open("res://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save(position))
	save_game_file.store_line(json_string)

func load_game():
	load_same_level()
	await get_tree().process_frame
	player = get_tree().current_scene.get_child(0)
	if not FileAccess.file_exists("res://savegame.save"):
		return
	
	var node_data = null
	var save_game_file = FileAccess.open("res://savegame.save", FileAccess.READ)
	while save_game_file.get_position() < save_game_file.get_length():
		var json_string = save_game_file.get_line()
		var json = JSON.new()
		var _parse_result = json.parse(json_string)
		node_data = json.get_data()
	player.global_position.x = node_data["x"]
	player.global_position.y = node_data["y"]
