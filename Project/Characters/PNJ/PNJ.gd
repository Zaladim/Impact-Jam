extends StaticBody2D

export (int) var speed
var screensize
var cont = 0
var text_actual = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport().size

func _speak(text):
	var container_text = load("res://Dialog/Label.tscn").instance()
	container_text._text(text)
	add_child(container_text)
	text_actual = container_text

func textPNJ():
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
		return
	cont += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
