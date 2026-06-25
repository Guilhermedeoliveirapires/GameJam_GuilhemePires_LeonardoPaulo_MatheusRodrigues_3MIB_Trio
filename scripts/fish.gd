extends Area2D

signal collected

@onready var particles: GPUParticles2D = $Particles
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("+1 peixe")
		collected.emit()
		sprite_2d.visible = false
		collision_shape_2d.set_deferred("disabled", true)
		particles.emitting = true
		particles.restart()
		await particles.finished
		queue_free()
