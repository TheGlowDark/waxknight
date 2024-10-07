extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@onready var sprite := $"../../Sprite2D"
@onready var attack_timer = $AttackTimer
@onready var summon_timer = $SummonTimer
@onready var ray_cast := $"../../RayCast2D"
@export var distance_to_player: int = 200
@export var attack_distance: int = 20
var has_knife: bool = false
var speed := 5000.0

func enter():
	# AudioManager.play_sound(AudioManager.WALKING_METAL, 1.0, -3)
	if not has_knife:
		animator.play("run")
	else:
		animator.play("knife_run")

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")

	var distance = (enemy.player.global_position - enemy.global_position)
	if not has_knife:
		sprite.scale.x = 1 if distance.x <= 0 else -1
		move_from_player(delta, distance)
	else:
		sprite.scale.x = -1 if distance.x <= 0 else 1
		move_to_player(delta, distance)
	enemy.move_and_slide()
	
	if distance.length() < attack_distance and attack_timer.is_stopped() and has_knife:
		attack()

func move_from_player(delta, distance):
	if distance.length() <= distance_to_player and not ray_cast.is_colliding():
			enemy.velocity.x = -distance.normalized().x * speed * delta
	elif ray_cast.is_colliding():
		state_transition.emit(self, "PrepareRatAttack")
		has_knife = true
	elif summon_timer.is_stopped():
		summon_timer.start()
		state_transition.emit(self, "Summon")

func move_to_player(delta, distance):
	if distance.length() >= attack_distance:
		enemy.velocity.x = distance.normalized().x * speed * delta
	else:
		enemy.velocity.x = distance.normalized().x * speed * delta * 0.1

func attack():
	if enemy.player.health > 0:
		attack_timer.start()
		state_transition.emit(self, 'Attack')
	else:
		state_transition.emit(self, "Idle")
