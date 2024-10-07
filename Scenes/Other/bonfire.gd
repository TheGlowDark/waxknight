extends Lightable


func _on_area_entered(area):
	var area_parent = area.get_parent()
	if not is_fired and (area is Lightable and area.is_fired == true or area_parent is Player):
		is_fired = true
		timer.start()
		animator.play("light")
		await animator.animation_finished
		animator.play("burning")
		GameManager.save_game()
