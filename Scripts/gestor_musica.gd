extends Node

@onready var reproductor = $AudioStreamPlayer

# Puedes cambiar esto para que tarde más o menos segundos en desvanecerse
var tiempo_fade: float = 1.0 

func _ready():
	# Mantenemos tu loop infinito
	reproductor.finished.connect(reproductor.play)

func cambiar_musica(nueva_cancion):
	# 1. Si es la misma canción, no hacemos nada
	if reproductor.stream == nueva_cancion and reproductor.playing:
		return
		
	# 2. Creamos nuestro animador automático (Tween)
	var tween = create_tween()
	
	# 3. Si hay algo sonando, hacemos el Fade Out primero
	if reproductor.playing:
		# Animamos el volumen hasta -80 (silencio)
		tween.tween_property(reproductor, "volume_db", -80.0, tiempo_fade)
		# Cuando termine de bajar el volumen, llamamos a la siguiente parte
		tween.tween_callback(func(): _iniciar_nueva_cancion(nueva_cancion))
	else:
		# Si estaba todo en silencio, pasamos directo a la nueva
		_iniciar_nueva_cancion(nueva_cancion)

# Esta función se ejecuta automáticamente cuando el Fade Out termina
func _iniciar_nueva_cancion(nueva_cancion):
	if nueva_cancion == null:
		# Si mandamos "vacío", lo apagamos y ya
		reproductor.stop()
		reproductor.stream = null
	else:
		# Si hay una canción nueva, la preparamos en silencio
		reproductor.stream = nueva_cancion
		reproductor.volume_db = -80.0 
		reproductor.play()
		
		# ¡Y hacemos el Fade In! (Subimos a 0.0)
		var tween_in = create_tween()
		tween_in.tween_property(reproductor, "volume_db", 0.0, tiempo_fade)
