
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"


var vel=Vector2(50,500)
var saltando=false

func _ready():
	# Initalization here
	pass

func _integrate_forces(s):
	
	var lv = s.get_linear_velocity()
	
	var jump=Input.is_action_pressed("jump")
	if(!saltando and jump):
		saltando=true
		s.set_linear_velocity(Vector2(lv.x,vel.y))
	
	var piso=-1
	

	
	for x in range(s.get_contact_count()):

		var ci = s.get_contact_local_normal(x)
		if (ci.dot(Vector2(0,-1))>0.6):
			saltando=false
			piso=x
		
	print(saltando)
	
	s.set_linear_velocity(Vector2(vel.x,lv.y))
	