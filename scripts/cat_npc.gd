extends Area2D

@export_multiline var fala: String = "Miau!"
@export var gato_nome: String = "Gato"

var ja_falou := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if has_node("NomeLabel"):
		$NomeLabel.text = gato_nome


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player" or ja_falou:
		return
	ja_falou = true
	var mundo = get_tree().get_first_node_in_group("cat_world")
	if mundo:
		mundo.falar_com_gato(gato_nome, fala)
