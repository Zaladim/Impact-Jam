extends CanvasLayer

onready var player = get_node("Player")

func _ready():
	set_process(true)
	
func _process(delta):
	if == 3:
		$hud_lives1.frame = 0
		$hud_lives2.frame = 0
	elif global_var.lives == 3:
		$hud_lives1.frame = 1
	elif global_var.lives == 2:
		$hud_lives1.frame = 2
	elif global_var.lives == 1:
		$hud_lives2.frame = 1
	elif global_var.lives == 0:
		$hud_lives2.frame = 2