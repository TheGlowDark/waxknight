extends Area2D

@export var speed := 150
@onready var animated_sprite = $AnimatedSprite2D
@onready var sound := preload("res://assets/sfx/levelobjects_s/water_drop.wav")
var damage: int = 1
var can_move: bool = true

func _ready():
	await animated_sprite.animation_finished
	animated_sprite.play("fall")

func _process(delta):
	if can_move:
		position.y += speed * delta

func _on_area_entered(area):
	var parent = area.get_parent()
	if area.name == "DamageArea" and parent is CharacterBase:
		parent._take_damage(damage)
		if parent is Enemy and parent.health > 0:
			var fsm = parent.fsm
			fsm.current_state.state_transition.emit(fsm.current_state, "Hit")
	if area is Lightable and area.is_fired:
		area.shut()

func _on_body_entered(_body):
	can_move = false
	animated_sprite.play("drop")
	if (get_tree().current_scene.player.global_position - global_position).length() <= 200:
		AudioManager.play_sound(sound, 0, 1)
	await animated_sprite.animation_finished
	queue_free()
