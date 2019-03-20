extends KinematicBody2D
signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 125
export var jump_speed = 300
export var gravity = 1000

var fly = false
var screen_size
var cont = 0
var stuck = false
var text_actual = null

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
	if fly:
		speed = 300
		jump_speed = 500
		
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_speed
	elif stuck:
		speed = 0
		jump_speed = 0
		
		if Input.is_action_just_pressed("ui_down"):
			if cont == 0:
				_speak("Félicitation ! Tu as réussi à terminer ce parcours...")
			elif cont == 1:
				text_actual.queue_free()
				_speak("Cependant, est ce que c'était difficile avec autant de pouvoirs ?")
			elif cont == 2:
				text_actual.queue_free()
				_speak("Je te propose quelque chose, à chaque fois que tu termineras ce parcours, je te retirerais l'une de tes capacités")
			elif cont == 3:
				text_actual.queue_free()
				_speak("Nous allons voir si tu es capable d'autant briller sans tous tes privilèges !")
			elif cont == 4:
				text_actual.queue_free()
				_speak("#{?&$ !")
			elif cont == 5:
				text_actual.queue_free()
				cont = 0
				fly=true
				stuck=false
				global_position = $"../Spawn/spr".global_position
				return
			cont += 1
	else:
		speed = 200
		jump_speed = 300
		gravity = 1300

func _speak(text):
	var container_text = load("res://Dialog/Label.tscn").instance()
	container_text._text(text)
	add_child(container_text)
	text_actual = container_text

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
		if get_col.collider.get_name() == "PNJ":
			stuck = true
			fly = false

func _on_Spike_body_entered():
	velocity.y = -jump_speed
