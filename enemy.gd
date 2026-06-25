extends CharacterBody2D

const SPEED = 80.0
const GRAVITY = 1000.0

var direction = -1

@onready var floor_left: RayCast2D = $FloorLeft
@onready var floor_right: RayCast2D = $FloorRight
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):

	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Troca direção nas bordas
	if direction == -1 and not floor_left.is_colliding():
		direction = 1

	elif direction == 1 and not floor_right.is_colliding():
		direction = -1

	# Movimento
	velocity.x = direction * SPEED

	# Flip sprite
	anim.flip_h = direction > 0

	# Animação
	anim.play("walk")

	# Move
	move_and_slide()
