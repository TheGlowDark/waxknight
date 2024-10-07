extends Node2D

@onready var waterdrop_scene := preload("res://Scenes/Other/waterdrop.tscn")

func spawn_waterdrop():
	var waterdrop = waterdrop_scene.instantiate()
	add_child(waterdrop)
	waterdrop.global_position = global_position


func _on_timer_timeout():
	spawn_waterdrop()
