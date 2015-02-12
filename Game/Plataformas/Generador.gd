
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
export(float) var tiempoMinimo
export(float) var tiempoMaximo
export(int,"Facil","Medio","Dificil") var dificultad=0


var Plataformas=[
preload("res://Plataformas/PlataformaChica.scn"),
preload("res://Plataformas/PlataformaMediana.scn"),
preload("res://Plataformas/PlataformaGrande.scn")
]

var tiempoRandom=0;
var tiempoAcumulable=0.0;


func _ready():
	# Initalization here
	tiempoRandom=randf()*(tiempoMaximo-tiempoMinimo)+tiempoMinimo
	set_fixed_process(true)



func _fixed_process(delta):
	
	if tiempoAcumulable>=tiempoRandom:
		tiempoAcumulable=0.0
		tiempoRandom=randf()*(tiempoMaximo-tiempoMinimo)+tiempoMinimo
		generarPlataforma()
	
	
	
	tiempoAcumulable+=delta

func generarPlataforma():
	var definePlataforma=randi()%20
	var limiteMenor
	var limiteMayor
	if(dificultad==0):
		limiteMenor=5
		limiteMayor=11
	elif(dificultad==1):
		limiteMenor=7
		limiteMayor=15
	elif(dificultad==2):
		limiteMenor=8
		limiteMayor=17
	
	var indicePlataforma
	
	if(definePlataforma<=limiteMenor):
		indicePlataforma=0
		
	elif(definePlataforma<=limiteMayor):
		indicePlataforma=1
		
	else:
		indicePlataforma=2
	
	var plataforma=Plataformas[indicePlataforma].instance()
	var pos =get_pos()+get_node("posicionPlataforma").get_pos()
	plataforma.set_pos(pos)
	get_parent().add_child(plataforma)
	
	
	
	