extends Node2D

const TILE := 70
const STONE_MID := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/stoneMid.png")
const STONE_LEFT := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/stoneLeft.png")
const STONE_RIGHT := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/stoneRight.png")
const STONE_CENTER := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/stoneCenter.png")
const TORCH := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/tochLit2.png")
const CHAIN := preload("res://kenney_platformer-art-deluxe/Base pack/Items/chain.png")


func _ready() -> void:
	_build_platforms()
	_add_decorations()
	_connect_collectibles()
	$PowerupSpeed.speed_collected.connect($Player._on_powerup_speed_speed_collected)
	$Door.level_completed.connect(_on_door_reached)


func _build_platforms() -> void:
	# [x, y, largura em tiles]
	var segments := [
		[0, 520, 10],
		[750, 470, 4],
		[1050, 420, 3],
		[1300, 520, 8],
		[1900, 450, 3],
		[2150, 380, 3],
		[2400, 520, 5],
		[2850, 470, 4],
		[3100, 520, 6],
	]
	for segment in segments:
		_add_platform_segment(segment[0], segment[1], segment[2])


func _add_platform_segment(start_x: int, y: int, width: int) -> void:
	for i in range(width):
		var texture := STONE_CENTER
		if width == 1:
			texture = STONE_MID
		elif i == 0:
			texture = STONE_LEFT
		elif i == width - 1:
			texture = STONE_RIGHT
		_add_tile(start_x + i * TILE, y, texture)


func _add_tile(x: int, y: int, texture: Texture2D) -> void:
	var body := StaticBody2D.new()
	body.position = Vector2(x, y)
	var sprite := Sprite2D.new()
	sprite.texture = texture
	sprite.centered = false
	var collision := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = Vector2(TILE, TILE)
	collision.position = Vector2(TILE / 2.0, TILE / 2.0)
	collision.shape = shape
	body.add_child(sprite)
	body.add_child(collision)
	$Platforms.add_child(body)


func _add_decorations() -> void:
	var torch_positions := [Vector2(120, 450), Vector2(1380, 450), Vector2(2880, 450), Vector2(3320, 450)]
	for pos in torch_positions:
		var torch := Sprite2D.new()
		torch.texture = TORCH
		torch.position = pos
		$Ambiente.add_child(torch)
	var chain_positions := [Vector2(800, 350), Vector2(2100, 310)]
	for pos in chain_positions:
		var chain := Sprite2D.new()
		chain.texture = CHAIN
		chain.position = pos
		$Ambiente.add_child(chain)


func _connect_collectibles() -> void:
	for fish in $Collectibles.get_children():
		fish.collected.connect(_on_fish_collected)


func _on_fish_collected() -> void:
	GameManager.pontuacao += 1
	$HUD.atualizar_pontuacao()


func _on_door_reached() -> void:
	get_tree().change_scene_to_file("res://scenes/cat_world.tscn")
