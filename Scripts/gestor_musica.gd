extends Node

@onready var reproductor = $AudioStreamPlayer

func _ready():
	# Mantenemos tu loop infinito
	reproductor.finished.connect(reproductor.play)

func cambiar_musica(nueva_cancion):
	# 1. Si es exactamente la misma canción y ya está sonando, no hacemos nada
	if reproductor.stream == nueva_cancion and reproductor.playing:
		return
		
	# 2. Si le mandamos "vacío" (null), apagamos la música por completo
	if nueva_cancion == null:
		reproductor.stop()
		reproductor.stream = null
		return
		
	# 3. Si hay una canción nueva, cambiamos el disco y le damos a Play de inmediato
	reproductor.stream = nueva_cancion
	reproductor.volume_db = 0.0 # Aseguramos que el volumen esté al máximo por si acaso
	reproductor.play()
