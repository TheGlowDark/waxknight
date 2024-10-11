extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@export var knockback_speed: int = 1000
@export var sound: AudioStreamWAV

func enter():
	if sound and not GameManager.cutscene_playing:
		AudioManager.play_sound(sound, 0, 1)
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	else:
		animator.play("hit")
		knockback()
		await animator.animation_finished
		state_transition.emit(self, "Idle")

func knockback():
	var direction = enemy.global_position - enemy.player.global_position
	enemy.velocity.x = direction.normalized().x * knockback_speed
	enemy.move_and_slide()
