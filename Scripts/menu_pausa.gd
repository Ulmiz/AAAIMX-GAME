extends Control

func _ready():
	# Al empezar el juego, el menú debe estar oculto
	visible = false

func _input(event):
	# Detectamos si aprietas ESC (la acción por defecto es "ui_cancel")
	if event.is_action_pressed("ui_cancel"):
		cambiar_pausa()

func cambiar_pausa():
	# Invertimos el estado de la pausa (Si es true pasa a false, y viceversa)
	var estado_nuevo = not get_tree().paused
	get_tree().paused = estado_nuevo
	
	# Mostramos u ocultamos el menú
	visible = estado_nuevo

# --- CONECTA ESTAS FUNCIONES A TUS BOTONES ---

func _on_boton_continuar_pressed():
	# Simplemente quitamos la pausa
	cambiar_pausa()

func _on_boton_config_pressed():
	print("Aquí abrirías tu ventana de configuración")
	# Aquí podrías hacer: $VentanaConfig.show()

func _on_boton_salir_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")
