extends KinematicBody2D



# Called when the node enters the scene tree for the first time.
var speedUp = 25
var speedDown = 200
var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()
var init
var pos
var explode = false

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
		$AnimatedBall.animation = "Explosion"
		$CollisionShape2D.disabled = true
		var t = Timer.new()
		t.set_wait_time(0.3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		global_position = init
		$AnimatedBall.animation = "Default"
		$CollisionShape2D.disabled = false
	
	pos = get_position()
	
	move_and_slide(velocity)
	
	var get_col = null
	
	for i in get_slide_count():
		get_col = get_slide_collision(i)
		if get_col != null:
			if get_col.collider.get_name() == "Player":
				if explode == false:
					get_col.collider._damage()
					explode = true
				velocity.y = 0
				velocity.x = 0
				$AnimatedBall.animation = "Explosion"
				$CollisionShape2D.disabled = true
				var t = Timer.new()
				t.set_wait_time(0.3)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				global_position = init
				$AnimatedBall.animation = "Default"
				$CollisionShape2D.disabled = false
				velocity.y = 100
				explode = false
