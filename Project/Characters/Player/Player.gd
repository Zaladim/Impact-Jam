extends KinematicBody2D
signal dead

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 125
export var jump_speed = 300
export var gravity = 1000

var life = 3
var shield = false

var base_speed = 125
var base_jump = 300
var damage_jump = 325

var fly = true
var fire_power = true
var screen_size
var cont = 0
var stuck = false
var text_actual = null
var dialog
var talking = false

var talk = true

var distance = Vector2()
var velocity = Vector2()
var direction = Vector2()

onready var fire = get_node("../Fire bullet")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	set_physics_process(true)
	dialog = 1
	fire.disabled = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if $Shield_time.is_stopped():
		shield = false
	
	$AnimatedSprite.play()
	if fly:
		speed = 300
		jump_speed = 500
		
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_speed
	elif stuck:
		speed = 0
		jump_speed = 0
		dialog = _dialog(dialog)		
	else:
		speed = base_speed
		jump_speed = base_jump
		gravity = 1000
	
	if Input.is_action_just_pressed("shoot"):
		if fire_power:
			if fire.disabled:
				_fire()

func _speak(text):
	var container_text = load("res://Dialog/Label.tscn").instance()
	container_text._text(text)
	add_child(container_text)
	text_actual = container_text
	
func _dialog(dialog):
	var nextText = Input.is_action_just_pressed("ui_accept")
	if dialog == 1 && talk:
		_speak("Vieil Homme : Bravo ! Tu as réussi à terminer ce parcours...")
		talk = false
		
	if dialog == 1 && nextText:
		if cont == 0:
			text_actual.queue_free()
			_speak("Cependant, est ce que c'était difficile avec autant de pouvoirs ?...")
		elif cont == 1:
			text_actual.queue_free()
			_speak("Je te propose quelque chose, à chaque fois que tu termineras ce parcours, je te retirerais l'une de tes capacités...")
		elif cont == 2:
			text_actual.queue_free()
			_speak("Nous allons voir si tu es capable d'autant briller sans tous tes privilèges !...")
		elif cont == 3:
			text_actual.queue_free()
			_speak("Reallocalous !")
		elif cont == 4:
			text_actual.queue_free()
			cont = 0
			dialog += 1
			fly = false
			stuck = false
			talk = true
			global_position = $"../Spawn/spr".global_position
			return dialog
		cont +=1
	
	if dialog == 2 && talk:
		_speak("Vieil Homme : Te revoilà !...")
		talk = false	
	
	elif dialog == 2 && nextText:
		if cont == 0:
			text_actual.queue_free()
			_speak("Tu as réussi à t'adapter mais tu étais encore largement avantagé par ton pouvoir de destruction...")
		elif cont == 1:
			text_actual.queue_free()
			_speak("C'est bien... Voyons si sans aucune de tes capacités tu es capable de le supporter !...")
		elif cont == 2:
			text_actual.queue_free()
			_speak("Reallocalous !")
		elif cont == 3:
			text_actual.queue_free()
			cont = 0
			dialog += 1
			stuck = false
			talk = true
			fire_power = false
			global_position = $"../Spawn/spr".global_position
			return dialog
		cont += 1
	
	if dialog == 3 && talk:
		_speak("Vieil Homme : Je suis impressionné de te revoir...")
		talk = false
	
	elif dialog == 3 && nextText:
		if cont == 0:
			text_actual.queue_free()
			_speak("J'espère que ce petit jeu entre nous t'as bien fait comprendre certaines choses...")
		elif cont == 1:
			text_actual.queue_free()
			_speak("Tu retiendras qu'avoir des privilèges c'est tant mieux pour toi, mais ne méprise jamais les autres car nous n'avons pas les mêmes histoires...")
		elif cont == 2:
			text_actual.queue_free()
			_speak("Freealous !")
		elif cont == 3:
			text_actual.queue_free()
			cont = 0
			dialog += 1
			stuck = false
			talk = true
			#bullet = false
			global_position = $"../Spawn/spr".global_position
			return dialog
		cont += 1
	return dialog

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
	
	var get_col = null
	
	if is_on_floor():
		velocity.y = 0
		direction.y = 0
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_speed
			direction.y = 1
			
	for i in get_slide_count():
		get_col = get_slide_collision(i)
		if get_col.normal == Vector2(0,1):
			velocity.y = 0
		if get_col.collider.get_name() == "PNJ":
			stuck = true
			fly = false

func _damage():
	if shield == false:
		shield = true
		velocity.y = -damage_jump
		life -= 1
		
		if $Shield_time.is_stopped():
			$Shield_time.start()
	
		if life <= 0:
			life = 3
			global_position = $"../Spawn/spr".global_position
			emit_signal("dead")

func _on_Spike_body_entered(body):
	if body.get_name() == get_name():
		if body.shield == false:
			_damage()

func _fire():
	fire.global_position = get_position()
	fire.disabled = false
	if $AnimatedSprite.animation == "Right":
		fire.left = false
		fire.global_position.x = get_position().x + 10
		fire.global_position.y = get_position().y - 10
	else:
		fire.left = true
		fire.global_position.x = get_position().x - 10
		fire.global_position.y = get_position().y - 10