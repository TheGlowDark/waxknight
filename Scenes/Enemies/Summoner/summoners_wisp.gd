extends Enemy

@export var speed: int = 5000
@onready var animator = $AnimationPlayer
@onready var timer = $Timer
var damage: int = 1
var is_dead: bool = false


func _ready():
	animator.play("run")
	var enemy = get_parent()
	player = enemy.player

func _process(delta):
	var direction = player.global_position - global_position
	velocity = direction.normalized() * delta * speed
	if not timer.is_stopped():
		velocity *= -1
	move_and_slide()
	sprite.scale.x = 1 if velocity.x >= 0 else -1
	if health <= 0 and not is_dead:
		is_dead = true
		animator.play("death")
		_die()


func _on_attack_area_area_entered(area):
	var parent = area.get_parent()
	if area.name == "DamageArea" and parent is CharacterBase:
		parent._take_damage(damage)
		if parent is Enemy and parent.health > 0:
			var p_fsm = parent.fsm
			p_fsm.current_state.state_transition.emit(p_fsm.current_state, "Hit")
		timer.start()
