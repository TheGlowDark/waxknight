extends State


@export var speed: float = 10000.0
@onready var animator := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"
@onready var player := $"../.."


func enter():
	animator.play("run")

func update(delta : float):
	if player.health <= 0:
		state_transition.emit(self, "Death")

	if not player.is_on_floor():
		state_transition.emit(self, "Fall")

	var input_dir = Input.get_axis("left", "right")
	move(input_dir, delta)

	if player.is_on_floor():
		if Input.is_action_just_pressed("attack"):
			state_transition.emit(self, "attack")
		if Input.is_action_just_pressed("attack2"):
			state_transition.emit(self, "Attack2")
		if Input.is_action_just_pressed("jump"):
			state_transition.emit(self, "Jump")
		if Input.is_action_just_pressed("dash"):
			state_transition.emit(self, "Dash")
		if Input.is_action_just_pressed("bounce"):
			state_transition.emit(self, "Bounce")
		if Input.is_action_just_pressed("heal"):
			state_transition.emit(self, "Heal")
		if Input.is_action_pressed("down"):
			state_transition.emit(self, "Descend")


func move(input_dir: float, delta: float):
	player.velocity.x = input_dir * speed * delta
	# flipping sprite if needed
	if input_dir:
		sprite.scale.x = sign(input_dir)

	if not input_dir:
		state_transition.emit(self, "idle")
	player.move_and_slide()
