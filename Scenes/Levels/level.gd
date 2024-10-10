extends Node2D

@onready var player = $Player
@onready var cutscene_sprite = $Cutscenes/Sprite2D
@onready var camera = $Camera2D
@onready var cutscene_animator = $Cutscenes/AnimationPlayer
@onready var cutscene_marker = $Cutscenes/Marker2D
@onready var canvas_modulate = $CanvasModulate



func _ready():
	camera.target = player

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		GameManager.load_game()
	


func _on_cutscene_area_body_entered(body):
	if body is Player:
		player.hide_ui()
		camera.target = null
		camera.global_position = cutscene_marker.global_position
		canvas_modulate.visible = false
		cutscene_animator.play("cutscene", -1, 0.1)
