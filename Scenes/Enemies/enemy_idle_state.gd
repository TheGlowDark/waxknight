extends State

@onready var animator := $"../../AnimationPlayer"
@onready var enemy := $"../.."

func enter():
	animator.play("idle")

func update(_delta):
	if enemy.health <= 0:
		state_transition.emit(self, "Death")
	
	enemy.velocity.x = 0
	enemy.move_and_slide() # for falling if needed
	
	if enemy.player and enemy.player.health > 0:
		state_transition.emit(self, "Run")


func _on_detection_area_body_entered(body):
	if body is Player:
		enemy.player = body
