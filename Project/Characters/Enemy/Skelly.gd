extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("../../Player")
onready var arrow = get_node("Arrow")

var dead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	$AnimatedSprite.animation = "Default"
	player.connect("dead", self, "_on_player_dead")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		hide()
		$CollisionShape2D.disabled = true
	else:
		show()
		$CollisionShape2D.disabled = false
		$AnimatedSprite.play()
		
		if get_position().x - player.get_position().x > 0:
			$AnimatedSprite.flip_h = true;
		else:
			$AnimatedSprite.flip_h = false;
		
		if abs(player.get_position().x - get_position().x) < 500:
			if arrow.disabled && arrow.ready:
				arrow.global_position = get_position()
				if get_position().x - player.get_position().x > 0:
					arrow.left = true
					arrow.global_position.x = get_position().x - 10
				else:
					arrow.left = false
					arrow.global_position.x = get_position().x + 10
				arrow.show()
				arrow.disabled = false
				arrow.ready = false
				arrow.velocity.y = (delta) * (-1*(get_position().y - player.get_position().y) * 50) - 30
			if !arrow.disabled:
				if $Timer.is_stopped():
					$Timer.start()
				
func _on_player_dead():
	dead = false
	show()
	$CollisionShape2D.disabled = false

func _on_Timer_timeout():
	arrow.disabled = true
	arrow.ready = true
