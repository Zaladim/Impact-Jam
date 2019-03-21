extends KinematicBody2D

# Member variables
var disabled = false
var velocity = Vector2()
var left = false
var move = false
var pos

func disable():
	if disabled:
		return
	$anim.play("shutdown")
	disabled = true


func _ready():
	set_physics_process(true)
	hide()
	$CollisionShape2D.disabled = true
	
func _physics_process(delta):
	if disabled:
		move = true
		velocity.x = 0
		velocity.y = 0
		hide()
		$CollisionShape2D.disabled = true
	else:
		$Sprite.play()
		if left:
			velocity.x = -300
			$Sprite.flip_h = true;
		else:
			velocity.x = 300
			$Sprite.flip_h = false;
		show()
		$CollisionShape2D.disabled = false
		move_and_slide(velocity)
		
	var get_col = null
	
	for i in get_slide_count():
		get_col = get_slide_collision(i)
		if get_col != null:
			if get_col.collider != get_parent() && !get_col.collider.is_in_group("Projectile"):				
				disabled = true
			if get_col.collider.is_in_group("Enemy"):
				get_node("../Enemy/" + get_col.collider.get_name()).dead = true
				
				
