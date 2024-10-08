extends Control

@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	appear()


func appear():
	animated_sprite.play("appear")
	await animated_sprite.animation_finished
	animated_sprite.play("idle")

func disappear():
	animated_sprite.play("disappear")
	await animated_sprite.animation_finished
	queue_free()
