extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var sprite = $"../../Sprite2D"
@export var sound: AudioStreamWAV


func enter():
	if sound and not GameManager.cutscene_playing:
		AudioManager.play_sound(sound, 0.3, 1)
	if enemy.health <= 0:
		state_transition.emit(self, "Death")

	animator.play("rat_attack")
	await animator.animation_finished
	sprite.scale.x = -sprite.scale.x
	state_transition.emit(self, "Run")
