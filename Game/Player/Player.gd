
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"


var vel=Vector2(220,-500)
var saltando=false
var dobleSaltando=false
var presionJump=false
var choque=500.0
var step
var validaNoPiso=500.0
var touchPress=false


var anim=""
var nuevaAnim=""



func _ready():
	# Initalization here
	set_process_input(true)
	pass

	
func _input(ev):
	if (ev.type==InputEvent.SCREEN_TOUCH):
		touchPress=true

func _integrate_forces(s):
	
	
	nuevaAnim=anim
	
	
	
	var lv = s.get_linear_velocity()
	
	step=s.get_step()
	
	var jump=Input.is_action_pressed("jump")||touchPress
	
	touchPress=false
	
	if((!saltando or !dobleSaltando )and jump and !presionJump):
		if(!saltando):
			saltando=true
		elif(!dobleSaltando):
			dobleSaltando=true
		s.set_linear_velocity(Vector2(lv.x,vel.y))
		validaNoPiso=0.0
	
	var piso=-1
	
	var lv = s.get_linear_velocity()
	
	if(validaNoPiso<0.15):
		validaNoPiso+=step
	
	for x in range(s.get_contact_count()):

		var ci = s.get_contact_local_normal(x)
		if (ci.dot(Vector2(0,-1))>0.6 and validaNoPiso>0.15):
			saltando=false
			dobleSaltando=false
			piso=x
	
	
	if choque>= 0.3 :
		choque=0.0
		s.set_linear_velocity(Vector2(vel.x,lv.y))
	else:
		choque+=step
		
	if(saltando || dobleSaltando):
		anim="Saltando"
		
	else:
		anim="Corriendo"
		
	
	if(lv.y>5):
		anim="Quieto"
	
	
	if(anim!=nuevaAnim):
		get_node("Anim").play(anim)
	
	presionJump=jump
	