extends Node

@export var cancion_para_esta_escena: AudioStream

func _ready():
	# Siempre le avisa al Gestor. 
	# Si hay canción, la toca. Si la casilla está vacía, manda 'null' y hace silencio.
	GestorMusica.cambiar_musica(cancion_para_esta_escena)
