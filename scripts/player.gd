extends CharacterBody2D

var SPEED := 300.0
const NORMAL_SPEED := 300.0
const SPEED_BOOST := 500.0
const BOOST_DURATION := 5.0
const JUMP_VELOCITY := -650.0
const GRAVITY := 1200.0

signal vida_alterada(vida_atual: int)

var boosted := false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var posicao_inicial: Marker2D = $"../PosicaoInicial"


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	if not is_on_floor():
		animated_sprite_2d.play("jump")
	elif direction != 0:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")

	move_and_slide()


func die():
	tomar_dano(1)


func tomar_dano(dano: int) -> void:
	GameManager.vidas -= dano
	if GameManager.vidas <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		respawn()
		vida_alterada.emit(GameManager.vidas)


func respawn() -> void:
	position = posicao_inicial.position


func apply_speed_boost() -> void:
	if boosted:
		return
	boosted = true
	SPEED = SPEED_BOOST
	await get_tree().create_timer(BOOST_DURATION).timeout
	SPEED = NORMAL_SPEED
	boosted = false


func _on_powerup_speed_speed_collected(body: Variant) -> void:
	if body.has_method("apply_speed_boost"):
		body.apply_speed_boost()
