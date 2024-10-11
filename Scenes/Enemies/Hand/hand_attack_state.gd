extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var shockwave_scene := preload("res://Scenes/Enemies/Hand/shockwave.tscn")
@onready var sound := preload("res://assets/sfx/hand/attack.wav")
var dash_speed := 20000
var initial_y_coordinate: int
var created_shockwave := false


func enter():
	animator.play("attack")
	if sound and not GameManager.cutscene_playing:
		AudioManager.play_sound(sound, 0, 1)
	initial_y_coordinate = enemy.global_position.y
	created_shockwave = false

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	
	fall_down(delta)
	
	if not animator.is_playing():
		create_shockwave()
		float_up()
		state_transition.emit(self, 'Idle')


func fall_down(delta):
	enemy.velocity.x = 0
	var tween = create_tween()
	enemy.velocity.y = dash_speed * delta
	tween.tween_property(enemy, "velocity:y", 0, 0.3)
	enemy.move_and_slide()

func float_up():
	var tween = create_tween()
	tween.tween_property(enemy, "global_position:y", initial_y_coordinate - 1, 0.5)
	await tween.finished

func create_shockwave():
	if not created_shockwave:
		created_shockwave = true
		var tween_right = create_tween()
		var tween_left = create_tween()
		var current_scene = enemy.get_parent()
		
		var shockwave_right = shockwave_scene.instantiate()
		current_scene.add_child(shockwave_right)
		shockwave_right.global_position.x = enemy.global_position.x + 32
		tween_right.tween_property(shockwave_right, "global_position:x", shockwave_right.global_position.x+100, 0.4)
		
		var shockwave_left = shockwave_scene.instantiate()
		current_scene.add_child(shockwave_left)
		shockwave_left.global_position.x = enemy.global_position.x - 32
		tween_left.tween_property(shockwave_left, "global_position:x", shockwave_left.global_position.x-100, 0.4)
