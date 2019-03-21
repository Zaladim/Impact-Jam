extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var disabled = true
var left = true
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	hide()
	$CollisionShape2D.disabled = true

func _physics_process(delta):
	if disabled:
		velocity.x = 0
		velocity.y = 0
		hide()
		$CollisionShape2D.disabled = true
	else:
		velocity.y = 5
		velocity.x = 0
		if left:
			velocity.x = -150
			$Sprite.flip_h = false;
		else:
			velocity.x = 150
			$Sprite.flip_h = true;
		show()
		$CollisionShape2D.disabled = false
		move_and_slide(velocity)
	
		var get_col = null
		
		for i in get_slide_count():
			get_col = get_slide_collision(i)
			if get_col != null:
				if get_col.collider.get_name() == "Player":
					if get_col.collider.shield == false:
						get_col.collider._damage()
				if get_col.collider != get_parent():				
					disabled = true
