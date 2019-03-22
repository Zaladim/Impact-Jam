extends CanvasLayer

onready var player = get_node("../Player")

func _ready():
	set_process(true)
	
func _process(delta):
	if player.life == 3:
		$hud_lives1.animation = "full_heart"
		$hud_lives2.animation = "full_heart"
		$hud_lives3.animation = "full_heart"
	elif player.life == 2:
		$hud_lives1.animation = "full_heart"
		$hud_lives2.animation = "full_heart"
		$hud_lives3.animation = "empty_heart"		
	elif player.life == 1:
		$hud_lives1.animation = "full_heart"
		$hud_lives2.animation = "empty_heart"
		$hud_lives3.animation = "empty_heart"
	if player.fire_power == true:
		$Fire.animation = "On"
	else:
		$Fire.animation = "Off"
	if player.fly == true:
		$Fly.animation = "On"
	else:
		$Fly.animation = "Off"