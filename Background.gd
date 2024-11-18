extends Node2D

onready var hud = $Hud
onready var spawn = $SpawnCanos
onready var chao = $Chao
onready var menu = $MenuIniciar
onready var musica = $MusicaFundo

const LOG_RECORD = "user://salvarrecord.save"
const LOG_PONTOS = "user://salvarpontos.save"

var pontuar = 0 setget set_pontos
var recorde = 0

func _ready():
	spawn.connect("criar_obstaculo", self, "_obstaculo_criado")
	carregar_recorde()
	
func novo_jogo():
	self.pontuar = 0
	spawn.iniciar()

func pontos_player():
	self.pontuar += 1
	
func set_pontos(x):
	pontuar = x
	hud.att_pontos(pontuar)
	salvar_pontos()

func _obstaculo_criado(obs):
	obs.connect("pontuar", self, "pontos_player")


func _on_AreaDano_body_entered(body):
	if body is Jogador:
		if body.has_method("matar"):
			body.matar()


func _on_Jogador_morto():
	game_over()
	
func game_over():
	spawn.parar()
	musica.stop()
	chao.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstaculos", "set_physics_process", false)
	
	if pontuar > recorde:
		recorde = pontuar
		salvar_recorde()
	
	menu.novo_game_over(pontuar, recorde)


func _on_MenuIniciar_novo_jogo():
	novo_jogo()

func salvar_recorde():
	var salvar = File.new()
	salvar.open(LOG_RECORD, File.WRITE)
	salvar.store_var(recorde)
	salvar.close()
	
	
func carregar_recorde():
	var dados = File.new()
	if dados.file_exists(LOG_RECORD):
		dados.open(LOG_RECORD, File.READ)
		recorde = dados.get_var()
		dados.close()

func salvar_pontos():
	var salvar = File.new()
	salvar.open(LOG_PONTOS, File.WRITE)
	salvar.store_var(pontuar)
	salvar.close()
