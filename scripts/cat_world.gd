extends Node2D

const TILE := 70
const GRASS_LEFT := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/grassMid.png")
const GRASS_MID := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/grassCenter_rounded.png")
const GRASS_RIGHT := preload("res://kenney_platformer-art-deluxe/Base pack/Tiles/grassMid.png")
const HEART := preload("res://kenney_platformer-art-deluxe/Candy expansion/Tiles/heart.png")

var gatos_falaram := 0
var final_mostrado := false


func _ready() -> void:
	add_to_group("cat_world")
	_build_mundo()
	_configurar_camera()
	_iniciar_entrada()
	await get_tree().create_timer(1.2).timeout
	falar_com_gato("???", "Lumi... você atravessou a porta!")


func _iniciar_entrada() -> void:
	$Ambiente/CanvasModulate.color = Color(0.15, 0.12, 0.2, 1)
	$Ambiente/FlashBranco.modulate.a = 1.0
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property($Ambiente/CanvasModulate, "color", Color(1.15, 1.1, 1.0, 1), 2.5)
	tween.tween_property($Ambiente/FlashBranco, "modulate:a", 0.0, 1.8)


func _build_mundo() -> void:
	var chao := [
		[0, 500, 18],
		[1300, 440, 3],
		[1520, 500, 4],
	]
	for segmento in chao:
		_add_plataforma(segmento[0], segmento[1], segmento[2])

	for i in range(6):
		var coracao := Sprite2D.new()
		coracao.texture = HEART
		coracao.position = Vector2(1480 + i * 55, 380)
		coracao.scale = Vector2(0.9, 0.9)
		$Ambiente.add_child(coracao)

	if GameManager.pontuacao >= 8:
		$NPCs/GatoSecreto.show()


func _configurar_camera() -> void:
	var cam := $Player/Camera2D
	cam.limit_left = 0
	cam.limit_right = 1850
	cam.limit_top = 0
	cam.limit_bottom = 720


func _add_plataforma(start_x: int, y: int, width: int) -> void:
	for i in range(width):
		var textura := GRASS_MID
		if i == 0:
			textura = GRASS_LEFT
		elif i == width - 1:
			textura = GRASS_RIGHT
		_add_tile(start_x + i * TILE, y, textura)


func _add_tile(x: int, y: int, textura: Texture2D) -> void:
	var body := StaticBody2D.new()
	body.position = Vector2(x, y)
	var sprite := Sprite2D.new()
	sprite.texture = textura
	sprite.centered = false
	var collision := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = Vector2(TILE, TILE)
	collision.position = Vector2(TILE / 2.0, TILE / 2.0)
	collision.shape = shape
	body.add_child(sprite)
	body.add_child(collision)
	$Platforms.add_child(body)


func falar_com_gato(nome: String, texto: String) -> void:
	texto = texto.replace("{peixes}", str(GameManager.pontuacao))
	%NomeGato.text = nome
	%DialogoLabel.text = texto
	%DialogoPanel.show()
	gatos_falaram += 1


func _on_fechar_dialogo_pressed() -> void:
	%DialogoPanel.hide()


func _on_zona_final_body_entered(body: Node2D) -> void:
	if body.name != "Player" or final_mostrado:
		return
	final_mostrado = true
	_mostrar_final()


func _mostrar_final() -> void:
	var peixes := GameManager.pontuacao
	var msg := "Bem-vindo ao Reino dos Gatos!\n\n"
	msg += "A escuridão ficou para trás. Aqui só há luz, risadas e soneca.\n\n"
	msg += "Peixes que você trouxe: %d\n" % peixes
	if peixes >= 8:
		msg += "\nVocê coletou TODOS os peixes! Os anciões te coroam com um bigode de honra!"
	elif peixes >= 4:
		msg += "\nBoa colheita! O banquete de peixes já está sendo preparado."
	else:
		msg += "\nMesmo com poucos peixes, você é herói por ter chegado até aqui."
	msg += "\n\nWhat's Behind the Door? ...Esperança."
	%TituloFinal.text = "Você venceu!"
	%MensagemFinal.text = msg
	%TelaFinal.show()
	$Ambiente/Confetes.emitting = true
	$Ambiente/Confetes.restart()


func _on_menu_principal_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")
