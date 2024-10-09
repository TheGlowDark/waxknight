extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."

func enter():
	# AudioManager.play_sound(AudioManager.ENEMY_HIT, 0.48, 20)
	enemy.velocity.x = 0

func update(_delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	else:
		animator.play("attack")
		await animator.animation_finished
		state_transition.emit(self, "Idle")
