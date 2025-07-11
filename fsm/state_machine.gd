extends Node

var current_state: Node = null

func _ready():
	switch_state("Patrol")

func switch_state(new_state_name: String, msg = null):
	if current_state:
		current_state.set_physics_process(false)
	var new_state = get_node(new_state_name)
	if new_state:
		current_state = new_state
		current_state.enter(msg)
		current_state.set_physics_process(true)

func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)
