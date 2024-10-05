extends Node2D

@onready var sprite = $Sprite
@onready var animator = $AnimationPlayer
@onready var timer = $Timer
@onready var fire_detection_area = $FireDetectionArea
@onready var lightsource = $Lightsource

var is_fired := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	global_position = get_global_mouse_position()

func _on_fire_detection_area_area_entered(_area):
	if not is_fired:
		is_fired = true
		timer.start()
		animator.play("light")
		await animator.animation_finished
		animator.play("burning")


func _on_timer_timeout():
	is_fired = false
	animator.play_backwards("light")
