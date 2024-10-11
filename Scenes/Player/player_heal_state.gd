extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player = $"../.."
@onready var sound := preload("res://assets/sfx/waxknight_s/eating_in_healing.wav")
@onready var sound1 := preload("res://assets/sfx/waxknight_s/heal_from_pocket.wav")

func enter():
	if player.health <= 0:
		state_transition.emit(self, "Death")
	AudioManager.play_sound(sound1, 0, 1)
	animator.play("check_pocket")
	await animator.animation_finished
	if player.heals > 0 and player.health < 3:
		AudioManager.play_sound(sound, 0, 1)
		animator.play("heal")
		await animator.animation_finished
		player.heals -= 1
		player.health += 1
	state_transition.emit(self, "Idle")
