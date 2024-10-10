extends Node2D
class_name Lightable

@onready var animator = $AnimationPlayer
@onready var timer = $Timer
@onready var lightsource = $Lightsource
@onready var sound := preload("res://assets/sfx/companion/lightened.wav")

var is_fired := false

func _on_area_entered(area):
	var area_parent = area.get_parent()
	if not is_fired and (area is Lightable and area.is_fired == true or area_parent is Player):
		is_fired = true
		if sound:
			AudioManager.play_sound(sound, 0, 1)
		timer.start()
		animator.play("light")
		await animator.animation_finished
		animator.play("burning")


func _on_timer_timeout():
	if is_fired:
		shut()

func shut():
	is_fired = false
	animator.play_backwards("light")
