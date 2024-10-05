extends State

@onready var animator := $"../../AnimationPlayer"
@onready var player := $"../.."
var first_time := true

func enter():
	if player.is_on_floor() or first_time:
		animator.play("idle")
	else:
		animator.play("fall")
	first_time = false

func update(_delta):
	if player.health <= 0:
		state_transition.emit(self, "Death")
	
	
	player.velocity.x = 0
	player.move_and_slide()

	if Input.get_axis("left", "right") and player:
			state_transition.emit(self, "Run")

	if player.is_on_floor():
		if Input.is_action_just_pressed("attack"):
			state_transition.emit(self, "Attack")
		if Input.is_action_just_pressed("up"):
			state_transition.emit(self, "Jump")
		if Input.is_action_just_pressed("dash"):
			state_transition.emit(self, "Dash")
