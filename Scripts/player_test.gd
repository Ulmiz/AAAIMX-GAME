extends CharacterBody2D

const SPEED = 300.0
var npc_cerca = null 

# --- REFERENCIAS VISUALES ---
@onready var visual_cuerpo = $Visuals/SpriteCuerpo
@onready var visual_pelo = $Visuals/SpritePelo
@onready var visual_ojos = $Visuals/SpriteOjos
@onready var visual_camisa = $Visuals/SpriteCamisa
@onready var visual_pantalon = $Visuals/SpritePantalon
@onready var label_nombre: Label = $Visuals/LabelNombre


# --- BANCO DE IMÁGENES ---
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

func _ready():
	cargar_apariencia()

func cargar_apariencia():
	if label_nombre:
		label_nombre.text = Global.nombre_jugador
	
	if visual_cuerpo:
		visual_cuerpo.modulate = Global.color_piel
	
	if visual_pelo and Global.idx_pelo < pelos.size():
		visual_pelo.texture = pelos[Global.idx_pelo]
		
	if visual_ojos and Global.idx_ojos < ojos.size():
		visual_ojos.texture = ojos[Global.idx_ojos]

	if visual_camisa and Global.idx_camisa < camisas.size():
		visual_camisa.texture = camisas[Global.idx_camisa]

	if visual_pantalon and Global.idx_pantalon < pantalones.size():
		visual_pantalon.texture = pantalones[Global.idx_pantalon]

# --- MOVIMIENTO ---
func _physics_process(_delta):
	# 1. ¡SEMÁFORO! Si estamos hablando, no nos movemos.
	if Global.hablando:
		return 
	
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

# --- INTERACCIÓN ---
func _input(event):
	# 1. Detectamos el botón
	# 2. Verificamos que haya un NPC cerca
	# 3. Verificamos que NO estemos hablando ya (El Semáforo)
	if event.is_action_pressed("interact") and npc_cerca != null and not Global.hablando:
		
		# Solo si cumple todo eso, llamamos a hablar UNA VEZ
		if npc_cerca.has_method("hablar"):
			npc_cerca.hablar()

# --- DETECCIÓN DE AREAS ---
func _on_area_2d_area_entered(area):
	var posible_npc = area.get_parent()
	# Verificamos si es un objeto interactuable
	if posible_npc.has_method("hablar"):
		npc_cerca = posible_npc
		if "label_aviso" in npc_cerca:
			npc_cerca.label_aviso.show()

func _on_area_2d_area_exited(area):
	if npc_cerca == area.get_parent():
		if "label_aviso" in npc_cerca:
			npc_cerca.label_aviso.hide()
		npc_cerca = null
