extends Node2D

onready var hud = $Hud
onready var spawn = $SpawnCanos
onready var chao = $Chao
onready var menu = $MenuIniciar
onready var musica = $MusicaFundo

onready var bg0 = $bg0
onready var bg1 = $bg1
onready var bg2 = $bg2
onready var bg3 = $bg3

var moedas = 0
var pontos = 0
var recorde = 0
var background = 0 

var pontuar = 0 setget set_pontos

func _ready():
	spawn.connect("criar_obstaculo", self, "_obstaculo_criado")
	var sdados = ScriptDados.carregar_dados()
	puxar_dados(sdados)
	ScriptDados.salvar_tudo(sdados)
	mudar_background()


func mudar_background():
	var bg = ScriptDados.estrutura.background
	if bg == 0:
		bg0.visible = true
		bg1.visible = false
		bg2.visible = false
		bg3.visible = false
		
	else: if bg == 1:
		
		bg0.visible = false
		bg1.visible = false
		bg2.visible = true
		bg3.visible = false
		
	else: if bg == 2: 
		
		bg0.visible = false
		bg1.visible = false
		bg2.visible = false
		bg3.visible = true
		
	else: if bg == 3:
		
		bg0.visible = false
		bg1.visible = true
		bg2.visible = false
		bg3.visible = false
	
func novo_jogo():
	self.pontuar = 0
	spawn.iniciar()

func pontos_player():
	self.pontuar += 1
	
func set_pontos(x):
	pontuar = x
	hud.att_pontos(pontuar)
	ScriptDados.salvar_pontos(pontuar)

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
	ScriptDados.salvar_moedas(moedas + pontuar)
	
	if pontuar > ScriptDados.estrutura.recorde:
		ScriptDados.salvar_recorde(pontuar)
		
	menu.novo_game_over(pontuar, ScriptDados.estrutura.recorde)


func _unhandled_input(event):
	if event.is_action_pressed("loja_open"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Ambiente/Loja.tscn")

func _on_MenuIniciar_novo_jogo():
	ScriptDados.carregar_dados()
	novo_jogo()

func puxar_dados(dados):
	moedas = dados.moedas
	pontos = dados.pontos
	recorde = dados.recorde
	background = dados.background
