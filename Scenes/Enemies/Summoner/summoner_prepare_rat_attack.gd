extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."
@export var attack_distance: int = 25

func enter():
	enemy.velocity.x = 0
	animator.play("idle")

func update(_delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	
	enemy.move_and_slide() # for falling if needed
	
	var distance = (enemy.player.global_position - enemy.global_position)
	if distance.length() <= attack_distance * 1.5:
		state_transition.emit(self, "RatAttack")
