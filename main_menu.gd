extends Control
var global_variables
var select_level


# Called when the node enters the scene tree for the first time.
func _ready():
	global_variables = get_node("/root/GlobalVariables")
	select_level = get_node("MenuCanvas/VBoxContainer/LevelSelectHBox/SelectLevel")
	$MenuCanvas/VBoxContainer/ToggleSound.button_pressed = global_variables.soundOn
	
	# Add all the levels to the dropdown.
	for i in range(1, global_variables.scenesList.size() - 1):
		#print(str(i))
		select_level.add_item(str(i))
	
	# Make sure the keyboard focus is set to the start button.
	# This lets players navigate the game by keyboard.
	$MenuCanvas/VBoxContainer/StartButton.grab_focus()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	# When the start button is pressed, start the chosen level.
	# Add 1 since levels start at 1 in the list, but IDs in the OptionButton start at 0.
	global_variables.startScene(select_level.get_selected_id() + 1)
	pass # Replace with function body.


func _on_toggle_sound_toggled(button_pressed):
	# When the Toggle Sound checkbox is pressed, set isMuted accordingly.
	global_variables.setSoundOn(button_pressed)
	#print(global_variables.soundOn)
	pass # Replace with function body.


func _on_about_button_pressed():
	$AboutMenu.showMenu()
	pass # Replace with function body.


func _on_about_menu_menu_closed():
	$MenuCanvas/VBoxContainer/AboutButton.grab_focus()
	pass # Replace with function body.
