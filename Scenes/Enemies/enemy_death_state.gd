extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."

func enter():
	animator.play("death")
	await animator.animation_finished
	enemy._die()
