extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player := $"../.."

func enter():
	animator.play("idle")

func update(_delta):
	player.velocity.x = 0
	player.move_and_slide()


	if Input.get_axis("left", "right"):
		state_transition.emit(self, "Run")

	if Input.is_action_just_pressed("attack"):
		state_transition.emit(self, "Attack")
	if Input.is_action_just_pressed("up") and player.is_on_floor():
		state_transition.emit(self, "Jump")
	if Input.is_action_just_pressed("dash") and player.is_on_floor():
		state_transition.emit(self, "Dash")
