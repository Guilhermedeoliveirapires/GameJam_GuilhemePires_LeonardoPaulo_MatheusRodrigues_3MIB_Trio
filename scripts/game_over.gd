extends Control


func _on_tentar_novamente_button_pressed() -> void:
	GameManager.reset_jogo()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
