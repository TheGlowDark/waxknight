extends PointLight2D

@export var light_scale: float = 1
@export var light_energy: float = 1
var current_frame := 0
var light_frames: Array


func _ready():
	var light_frame0 = preload("res://assets/textures/light/light0.png")
	var light_frame1 = preload("res://assets/textures/light/light1.png")
	var light_frame2 = preload("res://assets/textures/light/light2.png")
	light_frames = [light_frame0, light_frame1, light_frame2]


func _physics_process(_delta):
	texture = light_frames[current_frame]
	energy = light_energy
	texture_scale = light_scale


func _on_timer_timeout():
	current_frame = (current_frame + 1) % 3
