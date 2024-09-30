extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if fsm.current_state.name != 'Jump':
		fall(delta)

func fall(delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
