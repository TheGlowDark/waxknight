extends State

var speed: float = 10000.0
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float
@onready var jump_velocity: float = -2.0 * jump_height / jump_time_to_peak
@onready var jump_gravity: float = 2.0 * jump_height / (jump_time_to_peak**2)
@onready var fall_gravity: float = 2.0 * jump_height / (jump_time_to_descent**2)
@onready var animator := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"
@onready var player := $"../.."
@onready var sound1 := preload("res://assets/sfx/waxknight_s/afterjump.wav")
@onready var sound2 := preload("res://assets/sfx/waxknight_s/jump.wav")


func enter():
	AudioManager.play_sound(sound1, 0.08, 1)
	animator.play("jump")
	player.velocity.y = jump_velocity

func update(_delta : float):
	if player.health <= 0:
		state_transition.emit(self, "Death")

	var input_dir = Input.get_axis("left", "right")
	jump(input_dir, _delta)
	
	if Input.is_action_just_pressed("attack"):
		state_transition.emit(self, "attack")
	if Input.is_action_just_pressed("attack2"):
		state_transition.emit(self, "Attack2")
	if player.can_climb() and Input.is_action_pressed("up"):
		state_transition.emit(self, "Climb")
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
		AudioManager.play_sound(sound2, 0.7, 1)
		state_transition.emit(self, "Idle")

func get_gravity():
	return jump_gravity if player.velocity.y < 0.0 else fall_gravity
