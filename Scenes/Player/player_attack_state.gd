extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player = $"../.."
@export var sound: AudioStreamWAV

func enter():
	if sound and not GameManager.cutscene_playing:
		AudioManager.play_sound(sound, 0, 1)
	if player.health <= 0:
		state_transition.emit(self, "Death")
	animator.play("attack")
	await animator.animation_finished
	state_transition.emit(self, "Idle")
