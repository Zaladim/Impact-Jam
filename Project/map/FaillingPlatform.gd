extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speedUp = 25
var speedDown = 100
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()
var init

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	init = get_position().y

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _physics_process(delta):
	_move(delta)
	
func _move(delta):
	move_and_slide(velocity,Vector2(0,-1))
	var get_col = null
	
	if (get_slide_count() != 0):
		get_col = get_slide_collision(get_slide_count()-1)

	
	if get_position().y <= init:
		if get_col == null:
			distance.y = 0
			velocity.y = 0
			direction.y = 0;
	
	if !is_on_floor():
		if get_col != null:
			if get_col.collider.get_name() == "Player":
				move_and_slide(Vector2(0,5))
				var t = Timer.new()
				t.set_wait_time(0.5)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				distance.y = speedDown*delta
				velocity.y = (direction.y*distance.y)/delta
				direction.y = 1;
		
	else:
		if get_col != null:
			if get_col.collider.get_name() != "Player":
				distance.y = speedUp*delta
				velocity.y = (direction.y*distance.y)/delta
				direction.y = -1;
			
			