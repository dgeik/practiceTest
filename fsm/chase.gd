extends "res://fsm/state.gd"

func enter(_msg = null):
	enemy = get_parent().get_parent()
	player = enemy.get_parent().get_node("Player")
	state_machine = get_parent()
	print("преследует")

func physics_process(delta):
	$"../../Animation".play("move")
	if enemy.position.x > player.position.x: 
		enemy.direction = -1
	else: 
		enemy.direction = 1
	
	$"../../Sprite2D".flip_h = (enemy.direction == -1)
	$"../../GroundCheck".position.x = 16*enemy.direction
	$"../../GroundCheck".scale.x = enemy.direction
	enemy.velocity.x = enemy.speed * enemy.direction
	
	if not $"../../GroundCheck".is_colliding():
		enemy.velocity.x = 0
	else: enemy.velocity.x = enemy.speed * enemy.direction
	enemy.move_and_slide()
	
	if enemy.is_player_in_attack_range():
		state_machine.switch_state("Attack")
	elif not enemy.can_see_player():
		state_machine.switch_state("Patrol")
