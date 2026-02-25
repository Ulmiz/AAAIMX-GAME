extends Control

# --- REFERENCIAS VISUALES ---
# NOTA: Asegúrate de que estas rutas sean correctas. 
# Si te da error de "null instance", arrastra los nodos desde la izquierda hasta aquí.

# --- REFERENCIAS VISUALES CORREGIDAS (Basado en tu foto) ---

# InputNombre sí está dentro del HBoxContainer -> PanelIzquierdo
@onready var input_nombre: LineEdit = $HBoxContainer/PanelIzquierdo/InputNombre

# PanelDerecho está AFUERA, directo en la raíz.
# Y las imágenes están directas, no dentro de "Muñeco".
@onready var cuerpo: TextureRect = $HBoxContainer/PanelDerecho/Cuerpo
@onready var ojosA: TextureRect = $HBoxContainer/PanelDerecho/OjosA  # Ojo con la "A" mayúscula
@onready var pantalon: TextureRect = $HBoxContainer/PanelDerecho/Pantalon
@onready var camisa: TextureRect = $HBoxContainer/PanelDerecho/Camisa
@onready var pelo: TextureRect = $HBoxContainer/PanelDerecho/Pelo

# --- BASE DE DATOS DE ROPA ---
var pelos = [
	preload("res://Assets/Personaje/Pelos/pelo1.png"),
	preload("res://Assets/Personaje/Pelos/pelo2.png")
]
var ojos = [
	preload("res://Assets/Personaje/Ojos/ojos1.png"),
	preload("res://Assets/Personaje/Ojos/ojos2.png")
]
var camisas = [
	preload("res://Assets/Personaje/camisa/camisa1.png"),
	preload("res://Assets/Personaje/camisa/camisa2.png")
]
var pantalones = [
	preload("res://Assets/Personaje/pantalon/pantalon1.png"),
	preload("res://Assets/Personaje/pantalon/pantalon2.png")
]

# Indices actuales
var i_pelo = 0
var i_ojos = 0
var i_camisa = 0
var i_pantalon = 0
var color_actual = Color.WHITE

func _ready():
	crear_botones_color()
	actualizar_personaje()

# --- FUNCIONES DE CAMBIO ---
func cambiar_pelo(direccion: int): 
	i_pelo = wrapi(i_pelo + direccion, 0, pelos.size())
	actualizar_personaje()

func cambiar_camisa(direccion: int):
	i_camisa = wrapi(i_camisa + direccion, 0, camisas.size())
	actualizar_personaje()
	
func cambiar_pantalon(direccion: int):
	i_pantalon = wrapi(i_pantalon + direccion, 0, pantalones.size())
	actualizar_personaje()

func cambiar_ojos(direccion: int):
	i_ojos = wrapi(i_ojos + direccion, 0, ojos.size())
	actualizar_personaje()

# --- VISUALIZACIÓN (AQUÍ ESTABA EL ERROR) ---
func actualizar_personaje():
	# Usamos los nombres que definiste arriba (pelo, ojosA, camisa, etc.)
	pelo.texture = pelos[i_pelo]
	ojosA.texture = ojos[i_ojos]
	camisa.texture = camisas[i_camisa]
	pantalon.texture = pantalones[i_pantalon]
	cuerpo.modulate = color_actual 

# --- COLORES DE PIEL ---
func crear_botones_color():
	var colores = [Color.WHITE, Color.BISQUE, Color.TAN, Color.NAVY_BLUE, Color("#3d2812")]
	var contenedor = $HBoxContainer/PanelIzquierdo/GridColores
	
	# 1. Cargamos el molde UNA sola vez (es más eficiente hacerlo fuera del bucle)
	var molde = preload("res://Escenas/Menus/boton_color.tscn") 
	
	# 2. Limpiamos basura vieja
	for hijo in contenedor.get_children():
		hijo.queue_free()
	
	for col in colores:
		
		var btn = molde.instantiate()
		
		# Ahora sí, btn es un nodo real y podemos cambiar sus propiedades
		btn.custom_minimum_size = Vector2(20, 20)
		btn.modulate = col
		
		# Primero lo agregamos al árbol visual
		contenedor.add_child(btn)
		
		# Y conectamos la señal
		btn.pressed.connect(func(): 
			color_actual = col
			actualizar_personaje()
		)
# --- GUARDAR Y SALIR ---
func _on_boton_jugar_pressed():
	# Guardamos en la memoria GLOBAL
	if input_nombre:
		Global.nombre_jugador = input_nombre.text
	
	Global.color_piel = color_actual
	Global.idx_pelo = i_pelo
	Global.idx_ojos = i_ojos
	Global.idx_camisa = i_camisa
	Global.idx_pantalon = i_pantalon
	
	# Vamos al juego
	get_tree().change_scene_to_file("res://Escenas/Menus/controles_tutorial.tscn")
