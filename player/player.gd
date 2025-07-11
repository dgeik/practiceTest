extends CharacterBody2D

@onready var speed := 40
@onready var jump_force := -50
@onready var gravity := 50
@onready var direction_attack := 0
@onready var direction := 0
@onready var hp := 6
@onready var damage := 1
@onready var is_attacking := false
@onready var game_over_screen = preload("res://ui/game_over.tscn")

func take_damage(_damage):
	hp -= _damage
	$AnimationFlash.play("flash")

func _unhandled_input(event):
	direction = Input.get_axis("ui_left","ui_right")
	
	if direction:
		velocity.x = speed * direction
		direction_attack = direction
		$AnimatedSprite2D.flip_h = (direction == -1)
		$Hit.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_force
	
	if is_attacking:
		return
	
	if Input.is_action_just_pressed("ui_attack"):
		is_attacking = true
		$Hit/CollisionPolygon2D.disabled = false
		$Animation.play("attack")
	elif is_on_floor() and direction:
		$Animation.play("move")
	elif not is_on_floor():
		$Animation.play("jump")
	else:
		$Animation.play("idle")

func _physics_process(delta):
	$MainActivity.hp = hp
	
	velocity.y += gravity * delta
	if hp <= 0:
		get_tree().root.call_deferred("add_child",game_over_screen.instantiate())
		get_tree().paused = true
	
	move_and_slide()

func _on_animation_animation_finished(anim_name):
	if anim_name == "attack":
		is_attacking = false
		$Hit/CollisionPolygon2D.disabled = true

func _on_hit_area_entered(area):
	area.get_parent().take_damage(damage)
