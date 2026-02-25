extends Control

func _ready():
	# Reproduce la animación apenas inicia el juego
	$AnimationPlayer.play("intro")
	# Conectamos la señal de "cuando termine la animación"
	$AnimationPlayer.animation_finished.connect(_on_intro_finished)

func _on_intro_finished(anim_name):
	# Cuando acaba el logo, cambiamos al Menú
	get_tree().change_scene_to_file("res://Escenas/Menus/menu_principal.tscn")

func _input(event):
	# Truco: Si el jugador se impacienta y da click, salta la intro
	if event.is_action_pressed("ui_accept") or event is InputEventMouseButton:
		get_tree().change_scene_to_file("res://Escenas/Menus/menu_principal.tscn")
