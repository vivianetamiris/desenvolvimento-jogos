extends CharacterBody2D

const SPEED = 200
const JUMP_FORCE = -400
const GRAVITY = 900

var death_y = 600
var life = 2   # ← duas vidas

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("ui_left"):
		direction -= 1

	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()

	if position.y > death_y:
		die()

func take_damage():     # ← inimigo chama isto
	life -= 1
	print("Levou dano! Vida atual:", life)

	if life <= 0:
		die()

func die():
	print("Morreu!")
	get_tree().reload_current_scene()
