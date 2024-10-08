extends Camera2D

@export var target: Node2D
var tween

func _ready():
	pass


func _process(_delta):
	if target:
		global_position = target.global_position
