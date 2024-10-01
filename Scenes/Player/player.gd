extends CharacterBase
class_name Player

@onready var fsm = $FSM as FiniteStateMachine
@onready var point_light = $PointLight2D

func _physics_process(delta):
	point_light.energy = health
	point_light.texture_scale = health
	if fsm.current_state.name != 'Jump':
		super.fall(delta)
