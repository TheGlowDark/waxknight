extends CharacterBase
class_name Player

@onready var fsm = $FSM as FiniteStateMachine
@onready var point_light := $PointLight2D
@onready var timer_2 := $PointLight2D/Timer2
@onready var fire_area := $FireArea
@onready var collision_shape = $CollisionShape2D
@onready var damage_area = $DamageArea


var current_frame := 0
var light_frames: Array


func _ready():
	var light_frame0 = preload("res://assets/textures/light/light0.png")
	var light_frame1 = preload("res://assets/textures/light/light1.png")
	var light_frame2 = preload("res://assets/textures/light/light2.png")
	light_frames = [light_frame0, light_frame1, light_frame2]

func _physics_process(delta):
	update_light()
	if fsm.current_state.name != 'Jump':
		super.fall(delta)

func _on_timer_2_timeout():
	current_frame = (current_frame + 1) % 3

func can_climb():
	return fire_area.has_overlapping_bodies()

func can_descend():
	return damage_area.has_overlapping_bodies()

func update_light():
	var tween = create_tween()
	tween.tween_property(point_light, "texture_scale", max(0, health*0.5), 0.5)
	point_light.energy = max(0, health)
	point_light.texture = light_frames[current_frame]
