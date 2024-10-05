extends CharacterBase
class_name Player

@onready var fsm = $FSM as FiniteStateMachine
@onready var point_light = $PointLight2D
@onready var timer_2 = $PointLight2D/Timer2
var current_frame := 0
var light_frames: Array


func _ready():
	var light_frame0 = preload("res://assets/textures/light/light0.png")
	var light_frame1 = preload("res://assets/textures/light/light1.png")
	var light_frame2 = preload("res://assets/textures/light/light2.png")
	light_frames = [light_frame0, light_frame1, light_frame2]
	print(light_frames)

func _physics_process(delta):
	point_light.texture = light_frames[current_frame]
	point_light.energy = health
	point_light.texture_scale = health
	if fsm.current_state.name != 'Jump':
		super.fall(delta)

func _on_timer_2_timeout():
	current_frame = (current_frame + 1) % 3
