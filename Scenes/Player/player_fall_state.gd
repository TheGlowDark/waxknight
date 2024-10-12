extends State

@export var speed: float = 10000.0
@onready var animator := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"
@onready var player := $"../.."
@onready var coyote_area = $"../../Sprite2D/CoyoteArea"
@onready var sound1 := preload("res://assets/sfx/waxknight_s/jump.wav")
@onready var sound2 := preload("res://assets/sfx/waxknight_s/afterjump.wav")



func enter():
	animator.play("fall")

func update(delta : float):
	if player.health <= 0:
		state_transition.emit(self, "Death")
	fall(delta)
	if Input.is_action_just_pressed("jump") and coyote_area.get_overlapping_bodies().size() > 0:
		state_transition.emit(self, "Jump")
	if Input.is_action_just_pressed("attack"):
		state_transition.emit(self, "Attack")
	if Input.is_action_just_pressed("attack2"):
		state_transition.emit(self, "Attack2")

func fall(delta: float):
	var input_dir = Input.get_axis("left", "right")
	player.velocity.x = input_dir * speed * delta
	player.move_and_slide()
	# flipping sprite if needed
	if input_dir:
		sprite.scale.x = sign(input_dir)
	if player.is_on_floor():
		AudioManager.play_sound(sound1, 0.71, 0.5)
		state_transition.emit(self, "Idle")
