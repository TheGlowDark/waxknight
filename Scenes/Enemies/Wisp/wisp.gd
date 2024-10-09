extends Enemy

@export var speed: int = 5000
@export var direction: Vector2 = Vector2.LEFT
@onready var animator = $AnimatedSprite2D
var damage: int = 1
var is_dead: bool = false
#Raycasts
@onready var raycast_down = $RaycastDown
@onready var raycast_up = $RaycastUp
@onready var raycast_right = $RaycastRight
@onready var raycast_left = $RaycastLeft


func _ready():
	animator.play(get_str_direction())

func _process(delta):
	velocity = direction * delta * speed
	move_and_slide()
	update_direction()
	if health <= 0 and not is_dead:
		is_dead = true
		animator.play("death")
		_die()

func update_direction():
	if direction == Vector2.LEFT and raycast_left.is_colliding():
		direction = Vector2.RIGHT
		animator.play("right")
	elif direction == Vector2.RIGHT and raycast_right.is_colliding():
		direction = Vector2.LEFT
		animator.play("left")
	elif direction == Vector2.DOWN and raycast_down.is_colliding():
		direction = Vector2.UP
		animator.play("up")
	elif direction == Vector2.UP and raycast_up.is_colliding():
		direction = Vector2.DOWN
		animator.play("down")

func get_str_direction():
	var dict = {Vector2.LEFT: "left", Vector2.RIGHT: "right", Vector2.UP: "up", Vector2.DOWN: "down"}
	return dict[direction]

func _on_attack_area_area_entered(area):
	var parent = area.get_parent()
	if area.name == "DamageArea" and parent is CharacterBase:
		parent._take_damage(damage)
		if parent is Enemy and parent.health > 0:
			var p_fsm = parent.fsm
			p_fsm.current_state.state_transition.emit(p_fsm.current_state, "Hit")
