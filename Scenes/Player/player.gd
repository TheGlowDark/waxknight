extends CharacterBase
class_name Player

@onready var fsm = $FSM as FiniteStateMachine

func _physics_process(delta):
	if fsm.current_state.name != 'Jump':
		super.fall(delta)
