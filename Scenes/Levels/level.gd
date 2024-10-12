extends Node2D

@onready var player = $Player
@onready var cutscene_sprite = $Cutscenes/Sprite2D
@onready var camera = $Camera2D
@onready var cutscene_animator = $Cutscenes/AnimationPlayer
@onready var canvas_modulate = $CanvasModulate
@export var sound: AudioStreamWAV


func _ready():
	camera.target = player
	player.show_ui()

func _process(_delta):
	if Input.is_action_just_pressed("restart") and not GameManager.cutscene_playing:
		GameManager.load_game()

func _on_cutscene_area_body_entered(body):
	if body is Player:
		AudioServer.set_bus_mute(2, true)
		AudioServer.set_bus_mute(1, true)
		GameManager.cutscene_playing = true
		if sound:
			AudioManager.play_sound(sound, 0, 1)
		player.hide_ui()
		camera.target = null
		camera.global_position = cutscene_sprite.global_position - Vector2(20, 0)
		canvas_modulate.visible = false
		cutscene_animator.play("cutscene", -1, 0.1)
