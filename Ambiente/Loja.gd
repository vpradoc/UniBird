extends Node2D

onready var moedas = $Moedas

func _unhandled_input(event):
	if event.is_action_pressed("loja_open"):
		get_tree().change_scene("res://Background.tscn")
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Background.tscn")
		
func _ready():
	visible = true
	moedas.text = "Moedas: " + str(ScriptDados.estrutura.moedas)

func verificar_grana(bg, valor):
	var grana = ScriptDados.estrutura.moedas
	if grana >= valor:
		ScriptDados.salvar_moedas(grana - valor)
		moedas.text = "Moedas: " + str(grana - valor)
		ScriptDados.salvar_background(bg)
	else:
		return

func _on_Botao1_pressed():
		#Fundo 1
	verificar_grana(1, 10)

func _on_Botao2_pressed():
	#Fundo 2
	verificar_grana(2, 15)

func _on_Botao3_pressed():
	#Fundo 3
	verificar_grana(3, 25)
