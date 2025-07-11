extends CanvasLayer
@onready var killed_enemies := 0
@onready var hp := 0

func _physics_process(delta):
	$MarginContainer/KilledEnemies.set_text("Enemies: %s" % killed_enemies)
	$MarginContainer/TextureProgressBar.value = hp
