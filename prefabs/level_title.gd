extends Control
var global_variables

func _enter_tree():
	global_variables = get_node("/root/GlobalVariables")
	# $CanvasLayer/LevelTitle.text = "Level " + str(global_variables.currentScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	#$CanvasLayer/LevelTitle.text = textToDisplay()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/LevelTitle.text = textToDisplay()
	pass


func textToDisplay():
	var ttd = "Level " + str(global_variables.currentScene)
	ttd += "\nSound "
	if global_variables.soundOn():
		ttd += "on"
	else:
		ttd += "off"
	return ttd
