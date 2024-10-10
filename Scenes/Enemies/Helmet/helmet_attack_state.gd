extends State


@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
var dash_speed = 20000
@export var sound: AudioStreamWAV

func enter():
	animator.play("attack")
	await animator.animation_finished
	state_transition.emit(self, 'Idle')

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")

	var tween = create_tween()
	if enemy.sprite.scale.x == 1:
		enemy.velocity.x = dash_speed * delta
	else:
		enemy.velocity.x = -dash_speed * delta
	tween.tween_property(enemy, "velocity:x", 0, 0.4)
	enemy.move_and_slide()
