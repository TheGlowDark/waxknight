extends State

var speed: float = 10000.0
@onready var animator := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"
@onready var player := $"../.."
@onready var sound := preload("res://assets/sfx/waxknight_s/jump.wav")

func enter():
	animator.play("fall")

func update(delta : float):
	if player.health <= 0:
		state_transition.emit(self, "Death")
	fall(delta)

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
	

func fall(delta: float):
	var input_dir = Input.get_axis("left", "right")
	player.velocity.x = input_dir * speed * delta
	player.move_and_slide()
	# flipping sprite if needed
	if input_dir:
		sprite.scale.x = sign(input_dir)
	if player.is_on_floor():
		AudioManager.play_sound(sound, 0.7, 1)
		state_transition.emit(self, "Idle")
