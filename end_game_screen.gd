extends Control
var global_variables


# Called when the node enters the scene tree for the first time.
func _ready():
	global_variables = get_node("/root/GlobalVariables")
	$CanvasLayer/ReturnToMainButton.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_to_main_button_pressed():
	global_variables.startScene(0)
	pass # Replace with function body.
