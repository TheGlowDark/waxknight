extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."

func enter():
	animator.play("death", -1, 2)
	await animator.animation_finished
	enemy._die()
