extends State

@onready var animator := $"../../AnimationPlayer"

func enter():
	animator.play("attack")
	await animator.animation_finished
	state_transition.emit(self, "Idle")
