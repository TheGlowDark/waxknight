class_name CharacterBase extends CharacterBody2D


@onready var sprite := $Sprite2D
@export var health : int
var invincible : bool = false

#region Taking Damage

#Play universal damage sound effect for any character taking damage and flashing red
func damage_effects():
	after_damage_iframes()


#After we are done flashing red, we can take damage again
func after_damage_iframes():
	invincible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.DARK_RED, 0.05)
	tween.tween_property(self, "modulate", Color.WHITE, 0.05)
	tween.tween_property(self, "modulate", Color.RED, 0.05)
	tween.tween_property(self, "modulate", Color.WHITE, 0.05)
	await tween.finished
	invincible = false
	
func _take_damage(amount):
	if invincible:
		return
	health -= amount
	damage_effects()


func _die():
	#Remove/destroy this character once it's able to do so unless its the player
	await get_tree().create_timer(1.0).timeout
	if is_instance_valid(self):
		queue_free()

#endregion
