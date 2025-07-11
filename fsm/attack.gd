extends "res://fsm/state.gd"

func enter(_msg = null):
	enemy = get_parent().get_parent()
	state_machine = get_parent()
	player = enemy.get_parent().get_node("Player")
	print("атакует")
	
	await get_tree().create_timer(2.0).timeout
	$"../../Animation".play("attack")
	if enemy.player_in_attack == true:
		player.take_damage(enemy.damage)
	await get_tree().create_timer(0.4).timeout
	state_machine.switch_state("Chase")

func physics_process(delta):
	if not enemy.is_player_in_attack_range():
		state_machine.switch_state("Chase")
	elif not enemy.can_see_player():
		state_machine.switch_state("Patrol")

