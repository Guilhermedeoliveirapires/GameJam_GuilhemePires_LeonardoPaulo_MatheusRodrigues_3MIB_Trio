extends CanvasLayer

@onready var health_label: Label = $Control/HealthLabel
@onready var score_label: Label = $Control/ScoreLabel
@onready var coracoes: HBoxContainer = $Control/HBoxContainer
@onready var barra: ProgressBar = $Control/ProgressBar
@onready var timer_label: Label = $Control/TimerLabel

var texture_cheio = preload("res://assets/coracao_cheio.png")
var texture_vazio = preload("res://assets/coracao_vazio.png")

var tempo: float = 90.0


func _ready() -> void:
	var player = get_parent().get_node("Player")
	player.vida_alterada.connect(_on_player_vida_alterada)
	_on_player_vida_alterada(GameManager.vidas)
	atualizar_pontuacao()


func atualizar_vidas() -> void:
	health_label.text = "Vidas: " + str(GameManager.vidas)


func atualizar_pontuacao() -> void:
	score_label.text = "Peixes: " + str(GameManager.pontuacao)


func _on_player_vida_alterada(vida_atual: int) -> void:
	atualizar_vidas()
	for i in coracoes.get_child_count():
		var coracao = coracoes.get_child(i)
		if i < vida_atual:
			coracao.texture = texture_cheio
		else:
			coracao.texture = texture_vazio
	var tween = create_tween()
	tween.tween_property(barra, "value", vida_atual, 0.3)


func _process(delta: float) -> void:
	if get_tree().paused:
		return
	if tempo > 0:
		tempo -= delta
		timer_label.text = formatar_tempo(tempo)
	else:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func formatar_tempo(segundos: float) -> String:
	var minutos = int(segundos) / 60
	var segs = int(segundos) % 60
	return "%02d:%02d" % [minutos, segs]
