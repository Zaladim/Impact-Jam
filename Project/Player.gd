extends KinematicBody2D
signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 150
export var jump_speed = 350
export var gravity = 1000
var screen_size

var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    $AnimatedSprite.play()
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)
	
func _physics_process(delta):
	_move(delta)
	
func _move(delta):
	direction.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	
	distance.x = speed*delta
	velocity.x = (direction.x*distance.x)/delta
	velocity.y += gravity*delta
	
	if velocity.x > 0:
		$AnimatedSprite.animation = "Right"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "Left"
	
	move_and_slide(velocity,Vector2(0,-1))
	
	var get_col = get_slide_collision(get_slide_count()-1)
	
	
	if is_on_floor():
		velocity.y = 0
		direction.y = 0
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_speed
			direction.y = 1
			
	if get_col != null:
		if get_col.normal == Vector2(0,1):
			velocity.y = 0