extends State


var speed: float = 10000.0
@onready var animator := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"
@onready var player := $"../.."


func enter():
	player = $"../.."
	animator.play("run")

func update(delta : float):
	var input_dir = Input.get_axis("left", "right")
	move(input_dir, delta)


	if Input.is_action_just_pressed("attack"):
		state_transition.emit(self, "attack")
	if Input.is_action_just_pressed("up") and player.is_on_floor():
		state_transition.emit(self, "Jump")
	if Input.is_action_just_pressed("dash") and player.is_on_floor():
		state_transition.emit(self, "Dash")


func move(input_dir: float, delta: float):
	player.velocity.x = input_dir * speed * delta
	# flipping sprite if needed
	if input_dir:
		sprite.scale.x = sign(input_dir)

	if not input_dir:
		state_transition.emit(self, "idle")
	player.move_and_slide()
