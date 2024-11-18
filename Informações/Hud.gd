extends CanvasLayer

onready var contador = $pontos

func att_pontos(ponto_att):
	contador.text = str(ponto_att)
