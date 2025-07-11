extends CanvasLayer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://map.tscn")
	get_tree().root.get_node("Win").queue_free()
	get_tree().paused = false
