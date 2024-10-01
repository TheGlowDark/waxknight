extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."

func enter():
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	else:
		animator.play("hit")
		await animator.animation_finished
		state_transition.emit(self, "Run")
