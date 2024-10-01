extends CharacterBase
class_name Enemy

@onready var fsm = $FSM as FiniteStateMachine

var player: Player

func _physics_process(delta):
	super.fall(delta)
