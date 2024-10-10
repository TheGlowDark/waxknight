extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var timer = $Timer
@export var sound1: AudioStreamWAV
@export var sound2: AudioStreamWAV

func enter():
	if sound1:
		AudioManager.play_sound(sound1, 0, 1)
	enemy.velocity.x = 0
	animator.play("attack")
	timer.start()
	await animator.animation_finished
	enemy._die()


func _on_timer_timeout():
	if sound2:
		AudioManager.play_sound(sound2, 0, 1)
	enemy._die()
