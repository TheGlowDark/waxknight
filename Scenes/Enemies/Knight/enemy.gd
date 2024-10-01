extends CharacterBase
class_name Enemy

@onready var fsm = $FSM as FiniteStateMachine
@export var falling := true
var player: Player

func _physics_process(delta):
	if falling:
		super.fall(delta)
