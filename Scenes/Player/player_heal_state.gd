extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player = $"../.."


func enter():
	if player.health <= 0:
		state_transition.emit(self, "Death")
	animator.play("check_pocket")
	await animator.animation_finished
	if player.heals > 0 and player.health < 3:
		animator.play("heal")
		await animator.animation_finished
		player.heals -= 1
		player.health += 1
	state_transition.emit(self, "Idle")
