extends State

var speed: float = 10000.0
@onready var animator := $"../../AnimationPlayer"
@onready var sprite := $"../../Sprite2D"
@onready var player := $"../.."


func enter():
	animator.play("fall")

func update(delta : float):
	if player.health <= 0:
		state_transition.emit(self, "Death")
	fall(delta)
	#if Input.is_action_just_pressed("dash"):
		#state_transition.emit(self, "dash")

func fall(delta: float):
	var input_dir = Input.get_axis("left", "right")
	player.velocity.x = input_dir * speed * delta
	player.move_and_slide()
	# flipping sprite if needed
	if input_dir:
		sprite.scale.x = sign(input_dir)
	if player.is_on_floor():
		state_transition.emit(self, "Idle")
