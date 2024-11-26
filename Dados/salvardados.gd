extends Node

var local = "user://dados.save"


var estrutura = {
	"moedas": 0, 
	"pontos": 0,
	"recorde": 0,
	"background": 0
}

func salvar_jogo():
	var salvar = File.new()
	salvar.open(local, File.WRITE)
	salvar.store_var(estrutura)
	salvar.close()
	
func carregar_dados():
	var salvar = File.new()
	if salvar.file_exists(local):
		salvar.open(local, File.READ)
		var dados = salvar.get_var()
		return dados
	else:
		print("Não encontrei os dados.")
		return estrutura

func salvar_tudo(dados:Dictionary):
	
	estrutura = dados
	salvar_jogo()
	
		
func resetar_recorde():
	if estrutura.has("recorde"):
		estrutura.recorde = 0
		salvar_jogo()
	else:
		print("Erro ao salvar dados!")
		
func salvar_recorde(x):
	if estrutura.has("recorde"):
		estrutura.recorde = x
		salvar_jogo()
	else:
		print("Erro ao salvar dados!")
		
func salvar_background(x):
	if estrutura.has("background"):
		estrutura.background = x
		salvar_jogo()
	else:
		print("Erro ao salvar dados!")
		
func salvar_pontos(x):
	if estrutura.has("pontos"):
		estrutura.pontos = x
		salvar_jogo()
	else:
		print("Erro ao salvar dados!")

func salvar_moedas(x):
	if estrutura.has("moedas") && estrutura.has("pontos"):
		estrutura.moedas = x
		salvar_jogo()
	else:
		print("Erro ao salvar dados!")
	
func resetar_dados():
	
	var estrutura_padrao = {
	"moedas":0, 
	"pontos":0,
	"recorde":0,
	"background":0
}

	estrutura = estrutura_padrao.duplicate(true)
	salvar_jogo()
	return estrutura
	
