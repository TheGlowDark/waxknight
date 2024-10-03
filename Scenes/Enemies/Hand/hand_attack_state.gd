extends State


@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
var dash_speed := 20000


func enter():
	animator.play("attack")
	await animator.animation_finished
	state_transition.emit(self, 'Idle')

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")

	var tween = create_tween()
	enemy.velocity.y = dash_speed * delta
	tween.tween_property(enemy, "velocity:y", 0, 0.3)
	enemy.move_and_slide()
	
