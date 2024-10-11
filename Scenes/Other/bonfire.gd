extends Lightable

@export var sound1: AudioStreamWAV

func _on_area_entered(area):
	var area_parent = area.get_parent()
	if not is_fired and (area is Lightable and area.is_fired == true or area_parent is Player):
		if sound1:
			AudioManager.play_sound(sound1, 0, 1)
		is_fired = true
		timer.start()
		animator.play("light")
		await animator.animation_finished
		animator.play("burning")
		GameManager.save_game()
