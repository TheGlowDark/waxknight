extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player = $"../.."


func enter():
	if player.health <= 0:
		state_transition.emit(self, "Death")
	animator.play("attack2")
	await animator.animation_finished
	state_transition.emit(self, "Idle")
