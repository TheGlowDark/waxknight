extends State


@onready var animator := $"../../AnimationPlayer"
@onready var player := $"../.."
var dash_speed = 20000


func enter():
	animator.play("dash")
	await animator.animation_finished
	state_transition.emit(self, 'Idle')

func update(delta):
	if player.health <= 0:
		state_transition.emit(self, "Death")

	var tween = create_tween()
	if player.sprite.scale.x == 1:
		player.velocity.x = dash_speed * delta
	else:
		player.velocity.x = -dash_speed * delta
	tween.tween_property(player, "velocity:x", 0, 0.4)
	player.move_and_slide()
