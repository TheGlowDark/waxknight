extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player = $"../.."


func enter():
	animator.play("death", -1, 2)
	await animator.animation_finished
	GameManager.load_game()
	state_transition.emit(self, "Idle")
