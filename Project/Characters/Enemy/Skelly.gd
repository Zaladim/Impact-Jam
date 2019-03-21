extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("../Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	$AnimatedSprite.animation = "Default"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.play()
	
	if get_position().x - player.get_position().x > 0:
		$AnimatedSprite.flip_h = true;
	else:
		$AnimatedSprite.flip_h = false;
