extends Control

# Tus recursos de fotos
@export var todas_las_fotos: Array[FotoDato] 

# Referencias a nodos
@onready var grid = $ContenedorFotos/GridContainer
var foto_escena = preload("res://Escenas/FotoItem.tscn") 

func _ready():
	# ESTO ES LO NUEVO:
	# Al iniciar, revisa si hay basura en el grid y la borra.
	if grid:
		for hijo in grid.get_children():
			hijo.queue_free()

func mostrar_ano(ano_seleccionado: int):
	# 1. Seguridad: Si el grid no existe por alguna razón, no hace nada para no dar error
	if not grid:
		return

	# 2. Limpiar fotos anteriores
	for hijo in grid.get_children():
		hijo.queue_free()
	
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
	hide() 
	get_tree().paused = false
