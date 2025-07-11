extends CharacterBody2D

@onready var player_in_vision := false
@onready var player_in_attack := false

@onready var hp := 3
@onready var damage := 1
@onready var direction := 1
@onready var speed := 15

func _physics_process(delta):
	velocity.y += 50 * delta
	if hp <= 0:
		get_parent().get_node("Player/MainActivity").killed_enemies += 1
		queue_free()

func take_damage(_damage):
	hp -= _damage
	$AnimationFlash.play("flash")

func can_see_player():
	return player_in_vision

func is_player_in_attack_range():
	return player_in_attack

func _on_chase_body_entered(body):
	player_in_vision = true

func _on_chase_body_exited(body):
	player_in_vision = false

func _on_attack_body_entered(body):
	player_in_attack = true

func _on_attack_body_exited(body):
	player_in_attack = false

func _on_on_touch_attack_body_entered(body):
	body.take_damage(damage)
