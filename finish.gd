extends Area2D

@onready var win = preload("res://ui/win.tscn")

func _on_body_entered(body):
	get_tree().root.call_deferred("add_child",win.instantiate())
	get_tree().paused = true
