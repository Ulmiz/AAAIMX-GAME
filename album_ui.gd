extends Control

# Tus recursos de fotos
@export var todas_las_fotos: Array[FotoDato] 

# Referencias a nodos
@onready var grid = $ContenedorFotos/GridContainer
@onready var fondo_inicial = $Ubuntu
@onready var fondo_final = $Background
@onready var vbox_container = $"FiltroAños"
@onready var carga = $Ubuntu/AnimatedSprite2D
var foto_escena = preload("res://Escenas/FotoItem.tscn") 

func _ready():
	# Conectar la señal de cambio de visibilidad
	self.visibility_changed.connect(_on_visibility_changed)
	
	# Limpiar grid al inicio
	limpiar_grid()

# Esta función se llama CADA VEZ que la visibilidad cambia
func _on_visibility_changed():
	if self.visible:
		# ¡La pantalla se acaba de hacer visible!
		iniciar_secuencia_animacion()
	else:
		# La pantalla se ocultó - Reiniciar todo
		reiniciar_estado_completo()

func reiniciar_estado_completo():
	# Detener cualquier animación en curso
	if carga.is_playing():
		carga.stop()
	
	# Reiniciar a como inicia la escena
	fondo_inicial.visible = true
	fondo_final.visible = false
	vbox_container.visible = false
	
	# Limpiar todas las fotos del grid
	limpiar_grid()
	
	# Reiniciar la animación al primer frame (opcional)
	carga.frame = 0
	carga.play("carga")
	carga.stop()  # La dejamos lista pero detenida

func iniciar_secuencia_animacion():
	# Estado inicial para la animación
	fondo_final.visible = false
	vbox_container.visible = false
	fondo_inicial.visible = true
	
	# Reiniciar la animación por si acaso
	carga.stop()
	carga.play("carga")
	
	# Esperar a que termine la animación
	await carga.animation_finished
	
	# Cambiar fondos
	fondo_inicial.visible = false
	fondo_final.visible = true
	vbox_container.visible = true

func limpiar_grid():
	if grid:
		for hijo in grid.get_children():
			hijo.queue_free()

func mostrar_ano(ano_seleccionado: int):
	# 1. Seguridad: Si el grid no existe por alguna razón, no hace nada para no dar error
	if not grid:
		return

	# 2. Limpiar fotos anteriores
	limpiar_grid()
	
	# 3. Filtrar y crear las nuevas
	for foto in todas_las_fotos:
		if foto.año == ano_seleccionado:
			var nueva_foto = foto_escena.instantiate()
			grid.add_child(nueva_foto)
			# Asegúrate que tu escena FotoItem tiene la función set_datos
			if nueva_foto.has_method("set_datos"):
				nueva_foto.set_datos(foto)

# --- TUS BOTONES ---
# Asegúrate de que las señales (señal pressed) estén conectadas en el editor

func _on_button_pressed() -> void:
	mostrar_ano(2022)

func _on_button_2_pressed() -> void:
	mostrar_ano(2023)

func _on_button_3_pressed() -> void:
	mostrar_ano(2024)

func _on_button_4_pressed() -> void:
	mostrar_ano(2025)
	
func _on_button_5_pressed() -> void:
	mostrar_ano(2026)

func _on_cerrar_pressed(): 
	# Ocultar la pantalla (esto activará visibility_changed)
	hide() 
	get_tree().paused = false
