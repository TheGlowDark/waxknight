extends State

@onready var animator := $"../../AnimationPlayer" as AnimationPlayer
@onready var enemy := $"../.."
@onready var sprite := $"../../Sprite2D"
@onready var timer := $Timer
var speed := 5000.0

func enter():
	# AudioManager.play_sound(AudioManager.WALKING_METAL, 1.0, -3)
	animator.play("run")

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	
	var distance = (enemy.player.global_position - enemy.global_position)
	enemy.velocity.y = distance.normalized().y * speed * delta
	enemy.move_and_slide()
	
	if distance.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
	if not animator.is_playing() and timer.is_stopped():
		# enemy.velocity.x = distance.normalized().x * speed * delta
		timer.start()
		state_transition.emit(self, "Attack")
