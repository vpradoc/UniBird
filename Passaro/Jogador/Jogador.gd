extends RigidBody2D

class_name Jogador

signal morto

export var FORCA_CLIQUE = -350

onready var animacao = $AnimationPlayer
onready var morte_som = $morte
onready var clique_som = $clique

const ROTACAO = -30.0

var iniciado = false
var vivo = true

func _physics_process(_delta):
	if Input.is_action_just_pressed("clique") && vivo:
		if !iniciado:
			iniciar()
		clique()
		
	if rotation_degrees <= ROTACAO:
		angular_velocity = 0
		rotation_degrees = ROTACAO
	
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 5
		else:
			angular_velocity = 0
	
func iniciar():
	if iniciado: return
	iniciado = true
	gravity_scale = 10.0
	animacao.play("clique")

func clique():
	linear_velocity.y = FORCA_CLIQUE	
	angular_velocity = -8.0	
	clique_som.play()
		
func matar():
	if !vivo: return
	vivo = false
	morte_som.play()
	animacao.stop()
	emit_signal("morto")
