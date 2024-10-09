extends Area2D


var player: Player
@export var next_scene: String
@onready var interact_key = $InteractKey

func _process(_delta):
	if interact_key.visible and Input.is_action_just_pressed("up"):
		GameManager.load_next_level(next_scene)


func _on_body_entered(body):
	if body is Player:
		player = body
		interact_key.visible = true


func _on_body_exited(body):
	if body is Player:
		interact_key.visible = false
