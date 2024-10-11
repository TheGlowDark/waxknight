extends State

@export var speed: float = 10000.0
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@onready var jump_velocity: float = -2.0 * jump_height / jump_time_to_peak
@onready var jump_gravity: float = 2.0 * jump_height / (jump_time_to_peak**2)
@onready var fall_gravity: float = 2.0 * jump_height / (jump_time_to_descent**2)
@onready var animator := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"
@onready var player := $"../.."


func enter():
	animator.play("jump")
	player.velocity.y = jump_velocity

func update(_delta : float):
	if player.health <= 0:
		state_transition.emit(self, "Death")

	var input_dir = Input.get_axis("left", "right")
	jump(input_dir, _delta)
	if Input.is_action_just_pressed("dash"):
		state_transition.emit(self, "dash")
	if Input.is_action_just_pressed("bounce"):
			state_transition.emit(self, "Bounce")


func jump(input_dir: float, delta: float):
	player.velocity.y += get_gravity() * delta
	player.velocity.x = input_dir * speed * delta
	player.move_and_slide()
	# flipping sprite if needed
	if input_dir:
		sprite.scale.x = sign(input_dir)
	if player.is_on_floor():
		state_transition.emit(self, "Idle")
	

func get_gravity():
	return jump_gravity if player.velocity.y < 0.0 else fall_gravity
