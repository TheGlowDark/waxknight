extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player = $"../.."
@export var climb_speed: int = 20000


func enter():
	animator.play("climb", -1, 2)

func update(delta):
	var ver_input_dir = Input.get_axis("up", "down")
	if player.can_climb():
		if not ver_input_dir:
			animator.pause()
		else:
			animator.play("climb", -1, 2)

		player.velocity.y = sign(ver_input_dir) * climb_speed * delta
		player.move_and_slide()

		var hor_input_dir = Input.get_axis("left", "right")
		if hor_input_dir or player.is_on_floor() and ver_input_dir >= 0:
			state_transition.emit(self, "Run")
	else:
		state_transition.emit(self, "Run")
