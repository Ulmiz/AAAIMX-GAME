extends Node2D

@onready var Cerbelo = $StaticBody2D/AnimatedSprite2D

func _ready() -> void:
	Cerbelo.play("default")
