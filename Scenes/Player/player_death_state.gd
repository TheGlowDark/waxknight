extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player = $"../.."
@onready var sound := preload("res://assets/sfx/waxknight_s/waxknight_death.wav")


func enter():
	AudioManager.play_sound(sound, 0, 1)
	animator.play("death", -1, 2)
	await animator.animation_finished
	if not GameManager.cutscene_playing:
		GameManager.load_game()
	state_transition.emit(self, "Idle")
