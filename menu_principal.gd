extends Control

func _on_boton_jugar_pressed():
	# AQUÍ ESTÁ LA CLAVE: Vamos al Editor, no al juego directo
	get_tree().change_scene_to_file("res://Escenas/Editor_personaje.tscn")

func _on_boton_config_pressed():
	# Mostramos el panel de configuración (si lo creaste)
	$PanelConfig.visible = !$PanelConfig.visible

func _on_boton_creditos_pressed():
	$PanelCreditos.visible = !$PanelCreditos.visible

func _on_boton_salir_pressed():
	# Cierra el juego
	get_tree().quit()
