extends Area2D

export (int) var speed
var screensize
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
