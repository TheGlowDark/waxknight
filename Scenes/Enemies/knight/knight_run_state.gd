extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var sprite = $"../../Sprite2D"
var speed := 5000.0

func enter():
	# AudioManager.play_sound(AudioManager.WALKING_METAL, 1.0, -3)
	animator.play("run")

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	
	if enemy.is_on_floor():
		enemy.velocity.y = 0
	else:
		enemy.velocity.y += enemy.gravity * delta
	
	var distance = (enemy.player.global_position - enemy.global_position)
	enemy.velocity.x = distance.normalized().x * speed * delta
	enemy.move_and_slide()
	
	if distance.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1

	if distance.length() < 20:
		if enemy.player.health > 0:
			state_transition.emit(self, 'Attack')
		else:
			state_transition.emit(self, "Idle")
