extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var sprite = $"../../Sprite2D"



func enter():
	if enemy.health <= 0:
		state_transition.emit(self, "Death")

	animator.play("rat_attack")
	await animator.animation_finished
	sprite.scale.x = -sprite.scale.x
	state_transition.emit(self, "Run")
