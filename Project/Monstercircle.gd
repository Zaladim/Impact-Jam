extends RigidBody2D

var screensize

export var speed = 125
export var jump_speed = 300
export var gravity = 1000

var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()

func _ready():
	screensize = get_viewport().size

func _physics_process(delta):
	_move(delta)
	
func _move(delta):
	direction.x = 1
	distance.x = speed*delta
	velocity.x = 109900#(direction.x*distance.x)/delta
	velocity.y += gravity*delta
	
	velocity.y = -jump_speed
	direction.y = 1
	
	#for i in get_slide_count():
		#get_col = get_slide_collision(i)
		#if get_col.normal == Vector2(0,1):
		#	velocity.y = 0
		#if get_col.collider.get_name() == "PNJ":
		#	stuck = true
		#	fly = false