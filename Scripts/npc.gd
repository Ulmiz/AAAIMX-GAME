extends CharacterBody2D

@export var dialogue_resource: DialogueResource 
@export var dialogue_start: String = "start"      

const BALLOON_SCENE = preload("res://Dialogo/balloon.tscn")
@onready var label_aviso = $label_aviso

func _ready():
	label_aviso.hide()

func hablar():
	if dialogue_resource:
		
		Global.hablando = true 
		
		var balloon = BALLOON_SCENE.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
		
		balloon.tree_exited.connect(_terminar_dialogo)

func _terminar_dialogo():
	Global.hablando = false
