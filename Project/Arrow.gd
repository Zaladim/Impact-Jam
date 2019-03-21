extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var init
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	velocity.x = -100
	velocity.y = 10
	init = get_position()

func _physics_process(delta):
	move_and_slide(velocity)
	var get_col = null
	
	for i in get_slide_count():
		get_col = get_slide_collision(i)
		if get_col != null:
			$CollisionPolygon2D.disabled = true
			hide()
			velocity.x = 0
			if get_col.collider.get_name() == "Player":
				get_col.collider._damage()
