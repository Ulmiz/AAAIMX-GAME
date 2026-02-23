extends CharacterBody2D
@onready var visual_cuerpo = $AnimatedSprite2D
var direction: Vector2 
const SPEED = 200.0

func _ready():
	visual_cuerpo.play("default")

func _physics_process(_delta):
	
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction.x < 0:
		visual_cuerpo.flip_h = true
	elif direction.x > 0: 
		visual_cuerpo.flip_h = false
	else: 
		visual_cuerpo.play("default")
		
	if direction:
		velocity = direction * SPEED
		visual_cuerpo.play("run ")

	else:
		velocity = Vector2.ZERO

	move_and_slide()
