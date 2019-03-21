extends KinematicBody2D



# Called when the node enters the scene tree for the first time.
var speedUp = 25
var speedDown = 200
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()
var init
var pos

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	init = get_position()
	pos = get_position()
	velocity.y = 100
	$AnimatedBall.animation = "Default"
	
func _physics_process(delta):
	_move(delta)
	
func _move(delta):
	if get_position().x != pos.x:
		velocity.x = (get_position().x - pos.x) * 55
		
	if get_position().y == pos.y:
		if get_position().x == pos.x:
			global_position = init
	
	pos = get_position()
	
	move_and_slide(velocity)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
