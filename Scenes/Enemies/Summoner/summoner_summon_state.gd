extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var wisp_scene := preload('res://Scenes/Enemies/Summoner/summoners_wisp.tscn')
@export var sound: AudioStreamWAV

func enter():
	AudioManager.play_sound(sound, 0, 1)
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	animator.play("summon")
	await animator.animation_finished
	summon()
	state_transition.emit(self, "Idle")

func summon():
	var wisp = wisp_scene.instantiate()
	enemy.add_child(wisp)
	wisp.global_position = enemy.global_position
	wisp.global_position += Vector2(16, -16)
	
