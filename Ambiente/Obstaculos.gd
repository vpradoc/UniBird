extends Node2D

signal pontuar

onready var ponto_som = $ponto

const LOG = "user://salvarpontos.save"
var pontos = 0

func carregar_dado():
	var dados = File.new()
	if dados.file_exists(LOG):
		dados.open(LOG, File.READ)
		pontos = dados.get_var()
		dados.close()

var VELOCIDADE = 0

func _physics_process(delta):
	carregar_dado()
	VELOCIDADE = 200 + pontos * 10
	position.x += -VELOCIDADE * delta
	if global_position.x <= -200:
		queue_free()
		


func _on_Canos_body_entered(body):
	if body is Jogador:
		if body.has_method("matar"):
			body.matar()



func _on_Passagem_body_exited(body):
	if body is Jogador:
		ponto_som.play()
		emit_signal("pontuar")

