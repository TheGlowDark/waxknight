extends CharacterBase
class_name Player

@onready var fsm = $FSM as FiniteStateMachine
@onready var animator = $AnimationPlayer
@onready var point_light := $PointLight2D
@onready var timer_2 := $PointLight2D/Timer2
@onready var fire_area := $FireArea
@onready var collision_shape = $CollisionShape2D
@onready var damage_area = $DamageArea

var heals: int = 0
#UI
@onready var heals_icon = $UI/Heals
@onready var heals_label := $UI/Heals/Label
@onready var hp_container := $UI/HP
@onready var hp_icon_scene := preload("res://Scenes/UI/hp.tscn")


var current_frame := 0
var light_frames: Array


func _ready():
	var light_frame0 = preload("res://assets/textures/light/light0.png")
	var light_frame1 = preload("res://assets/textures/light/light1.png")
	var light_frame2 = preload("res://assets/textures/light/light2.png")
	light_frames = [light_frame0, light_frame1, light_frame2]

func _physics_process(delta):
	update_light()
	update_ui()
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
	tween.tween_property(point_light, "texture_scale", max(0, health*0.4), 0.5)
	point_light.energy = max(0, health)
	point_light.texture = light_frames[current_frame]

func update_ui():
	heals_label.text = str(heals)
	update_hp_icons()

func update_hp_icons():
	var hp_icons = hp_container.get_children()
	var delta_hp = health - hp_icons.size()
	if delta_hp > 0:
		for i in range(delta_hp):
			var hp_icon = hp_icon_scene.instantiate()
			hp_container.add_child(hp_icon)
	elif delta_hp < 0:
		for i in range(-delta_hp):
			var hp_icon = hp_container.get_child(-1)
			hp_icon.disappear()

func hide_ui():
	heals_icon.visible = false
	hp_container.visible = false

func show_ui():
	heals_icon.visible = true
	hp_container.visible = true
