extends Node2D

@onready var sprite = $Cutscenes/Sprite2D
@onready var animation_player = $Cutscenes/AnimationPlayer
@onready var animator := $"../../AnimationPlayer"
@onready var camera = $Camera2D
@onready var player = $Player
@onready var canvas_modulate = $CanvasModulate
@export var sound: AudioStreamWAV


func _ready():
	canvas_modulate.visible = false
	animation_player.play("cutscene", -1, 0.1)
	player.hide_ui()
	await animation_player.animation_finished
	if sound:
		AudioManager.play_sound(sound, 0, 1)
	camera.target = player
	canvas_modulate.visible = true
	player.show_ui()


func _process(_delta):
	if Input.is_action_just_pressed("skip"):
		animation_player.stop()
		camera.target = player
		canvas_modulate.visible = true
