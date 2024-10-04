extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var shockwave_scene := preload("res://Scenes/Enemies/Hand/shockwave.tscn")
var dash_speed := 20000
var initial_position: Vector2
var created_shockwave := false


func enter():
	animator.play("attack")
	initial_position = enemy.global_position
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
	tween.tween_property(enemy, "global_position", initial_position, 0.5)
	await tween.finished

func create_shockwave():
	if not created_shockwave:
		created_shockwave = true
		var tween_right = create_tween()
		var tween_left = create_tween()
		
		var shockwave_right = shockwave_scene.instantiate()
		shockwave_right.global_position.x = enemy.global_position.x + 32
		enemy.add_child(shockwave_right)
		tween_right.tween_property(shockwave_right, "global_position:x", shockwave_right.global_position.x+80, 0.4)
		
		var shockwave_left = shockwave_scene.instantiate()
		shockwave_left.global_position.x = enemy.global_position.x - 32
		enemy.add_child(shockwave_left)
		tween_left.tween_property(shockwave_left, "global_position:x", shockwave_left.global_position.x-80, 0.4)
