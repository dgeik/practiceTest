extends "res://fsm/state.gd"

func enter(_msg = null):
	enemy = get_parent().get_parent()
	state_machine = get_parent()
	print("начал патрулирль")

func physics_process(delta):
	$"../../Animation".play("move")
	enemy.velocity.x = enemy.speed * enemy.direction
	
	if not $"../../GroundCheck".is_colliding():
		enemy.direction *= -1
		$"../../Sprite2D".flip_h = (enemy.direction == -1)
		$"../../GroundCheck".scale.x = enemy.direction
		$"../../GroundCheck".position.x = 16*enemy.direction
	enemy.move_and_slide()
	
	if enemy.can_see_player():
		state_machine.switch_state("Chase")
