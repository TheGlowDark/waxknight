extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player := $"../.."

func enter():
	animator.play("idle")

func update(_delta):
	if player.health <= 0:
		state_transition.emit(self, "Death")
	
	player.velocity.x = 0
	player.move_and_slide()


	if Input.get_axis("left", "right"):
		state_transition.emit(self, "Run")

	if player.is_on_floor():
		if Input.is_action_just_pressed("attack"):
			state_transition.emit(self, "Attack")
		if Input.is_action_just_pressed("up"):
			state_transition.emit(self, "Jump")
		if Input.is_action_just_pressed("dash"):
			state_transition.emit(self, "Dash")
	else:
		animator.play("fall")
