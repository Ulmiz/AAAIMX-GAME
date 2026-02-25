extends Area2D

# --- VARIABLES ---
# Esta es la variable CLAVE. Arrastra aquí el nodo AlbumUI desde el Inspector.
@export var album_ui: Control 

# El texto que dice "E"
@onready var aviso_tecla = $AvisoTecla 

var jugador_cerca = false

func _ready():
	# Conexiones de señales (está bien como lo tenías)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Ocultamos el aviso al inicio
	if aviso_tecla:
		aviso_tecla.hide()
	
	# Seguridad: Avisarte si olvidaste conectar el álbum
	if album_ui == null:
		print("¡ERROR! Falta asignar el nodo 'AlbumUi' en el Inspector del libro.")

func _input(event):
	# Detectamos la tecla (asegúrate que en Mapa de Entradas se llame "interact")
	if jugador_cerca and event.is_action_pressed("interact"):
		abrir_o_cerrar_album()

func abrir_o_cerrar_album():
	if album_ui == null: return # Evita crasheos si está vacío
	
	if album_ui.visible:
		# --- CERRAR ---
		album_ui.hide()
		get_tree().paused = false # Reanudar juego
	else:
		# --- ABRIR ---
		album_ui.show()
		
		# Aquí llamamos a tu función con "año" (ñ)
		if album_ui.has_method("mostrar_año"):
			album_ui.mostrar_año(2022) 
		elif album_ui.has_method("mostrar_anio"):
			# Por si acaso en el script del UI le pusiste "anio"
			album_ui.mostrar_anio(2022)
			
		get_tree().paused = true # Pausar juego

# --- DETECCIÓN ---

func _on_body_entered(body):
	# Actualizado para "player_test"
	if body.name == "player_test" or body.is_in_group("player_test"):
		jugador_cerca = true
		if aviso_tecla: aviso_tecla.show()

func _on_body_exited(body):
	if body.name == "player_test" or body.is_in_group("player_test"):
		jugador_cerca = false
		if aviso_tecla: aviso_tecla.hide()
		
		# Si te alejas, cierra el álbum
		if album_ui and album_ui.visible:
			album_ui.hide()
			get_tree().paused = false
