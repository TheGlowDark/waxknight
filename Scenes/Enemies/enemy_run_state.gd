extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var sprite := $"../../Sprite2D"
@onready var timer := $Timer
@export var attack_distance: int = 20
@export var speed := 4000.0

func enter():
	# AudioManager.play_sound(AudioManager.WALKING_METAL, 1.0, -3)
	animator.play("run")

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")

	
	var distance = (enemy.player.global_position - enemy.global_position)
	if distance.length() >= attack_distance:
		enemy.velocity.x = distance.normalized().x * speed * delta
	else:
		enemy.velocity.x = distance.normalized().x * speed * delta * 0.1
	enemy.move_and_slide()
	
	if distance.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1

	if distance.length() < attack_distance and timer.is_stopped():
		if enemy.player.health > 0:
			timer.start()
			state_transition.emit(self, 'Attack')
		else:
			state_transition.emit(self, "Idle")
