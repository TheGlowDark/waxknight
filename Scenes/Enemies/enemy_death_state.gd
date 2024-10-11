extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@export var sound1: AudioStreamWAV
@export var sound2: AudioStreamWAV

func enter():
	if sound1 and not GameManager.cutscene_playing:
		AudioManager.play_sound(sound1, 0, 1)
	animator.play("death")
	await animator.animation_finished
	if sound2 and not GameManager.cutscene_playing:
		AudioManager.play_sound(sound2, 0, 1)
	enemy._die()
