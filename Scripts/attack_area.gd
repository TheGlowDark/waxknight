extends Area2D

@export var damage: int


func _on_area_entered(area):
	var parent = area.get_parent()
	if area.name == "DamageArea" and parent is CharacterBase:
		parent._take_damage(damage)
		if parent is Enemy and parent.health > 0:
			var fsm = parent.fsm
			fsm.current_state.state_transition.emit(fsm.current_state, "Hit")
