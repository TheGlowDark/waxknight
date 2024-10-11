extends Lightable

@onready var sound1 := preload("res://assets/sfx/levelobjects_s/checkpoint.wav")

func _on_area_entered(area):
	var area_parent = area.get_parent()
	if not is_fired and (area is Lightable and area.is_fired or area_parent is Player):
		is_fired = true
		AudioManager.play_sound(sound1, 0, 1)
		timer.start()
		animator.play("light")
		await animator.animation_finished
		animator.play("burning")
		GameManager.save_game()
