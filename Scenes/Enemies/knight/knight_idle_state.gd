extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."

func enter():
	animator.play("idle")

func update(delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")

	if enemy.is_on_floor():
		enemy.velocity.y = 0
	else:
		enemy.velocity.y += enemy.gravity * delta
		enemy.move_and_slide()
	
	if enemy.player and enemy.player.health > 0:
		state_transition.emit(self, "Run")


func _on_detection_area_body_entered(body):
	if body is Player:
		enemy.player = body
