extends Area2D

var player: Player
@onready var title_animation = $"../AnimationPlayer"

func _on_body_entered(body):
	if body is Player:
		title_animation.play()
