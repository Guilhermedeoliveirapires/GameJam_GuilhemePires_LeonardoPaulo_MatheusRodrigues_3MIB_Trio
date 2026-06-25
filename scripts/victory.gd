extends Control


func _ready() -> void:
	%ScoreLabel.text = "Pontuação: %d peixes" % GameManager.pontuacao


func _on_menu_principal_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")
