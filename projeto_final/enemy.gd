extends CharacterBody2D

@export var speed = 80
@export var dano = 20
var player = null
var pode_dar_dano = true

func _ready():
	player = get_tree().get_root().find_child("Player", true, false)
	$AreaDano.body_entered.connect(_on_AreaDano_body_entered)

func _physics_process(delta):
	if player:
		var direcao = (player.global_position - global_position).normalized()
		velocity = direcao * speed
		move_and_slide()

###################################
#   SISTEMA DE DANO
###################################

func _on_AreaDano_body_entered(body):
	if body.name == "Player" and pode_dar_dano:
		pode_dar_dano = false
		body.receber_dano(dano)
		esperar_e_liberar()

func esperar_e_liberar():
	await get_tree().create_timer(1).timeout
	pode_dar_dano = true
