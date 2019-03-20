extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 300
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(velocity,Vector2(0,-1))
	var get_col = get_slide_collision(get_slide_count()-1)
	
	if get_col != null:
		if get_col.collider.get_name() == "Player":
			distance.y = speed*delta
			velocity.y = (direction.y*distance.y)/delta
			direction.y = -1;
			
			


func _physics_process(delta):
	_move(delta)
	
func _move(delta):
	move_and_slide(velocity,Vector2(0,-1))
	var get_col = get_slide_collision(get_slide_count()-1)
	
	if get_col != null:
		if get_col.collider.get_name() == "Player":
			distance.y = speed*delta
			velocity.y = (direction.y*distance.y)/delta
			direction.y = -1;
			
			