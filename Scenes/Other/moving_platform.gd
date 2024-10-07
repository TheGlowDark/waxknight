extends CharacterBody2D

@export var speed: int = 5000
@export var direction: Vector2 = Vector2.DOWN
#Raycasts
@onready var raycast_down = $RaycastDown
@onready var raycast_up = $RaycastUp
@onready var raycast_right = $RaycastRight
@onready var raycast_left = $RaycastLeft


func _process(delta):
	velocity = direction * delta * speed
	move_and_slide()
	update_direction()

func update_direction():
	if direction == Vector2.LEFT and raycast_left.is_colliding():
		direction = Vector2.RIGHT
	elif direction == Vector2.RIGHT and raycast_right.is_colliding():
		direction = Vector2.LEFT
	elif direction == Vector2.DOWN and raycast_down.is_colliding():
		direction = Vector2.UP
	elif direction == Vector2.UP and raycast_up.is_colliding():
		direction = Vector2.DOWN

