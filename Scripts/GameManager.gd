extends Node


var player: Player
var config = ConfigFile.new()

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		load_game()

func reset():
	load_same_level()

func load_next_level(next_scene: String):
	get_tree().call_deferred("change_scene_to_file", next_scene)
	
func load_same_level():
	get_tree().call_deferred("reload_current_scene")

func save_game():
	player = get_tree().current_scene.get_child(0)
	config.set_value("Player", "x", round(player.global_position.x))
	config.set_value("Player", "y", round(player.global_position.y))
	config.save("res://savefile.cfg")

func load_game():
	player = get_tree().current_scene.get_child(0)
	var save_file = config.load("res://savefile.cfg")
	if save_file == OK:
		player.global_position.x = config.get_value("Player", "x")
		player.global_position.y = config.get_value("Player", "y")
		player.health = 3
		player.sprite.self_modulate.a = 255
