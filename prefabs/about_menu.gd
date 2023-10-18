extends CanvasLayer
signal menu_closed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func showMenu():
	# Call this from other scripts to show the menu.
	self.show()
	$VBoxContainer/CloseButton.grab_focus()


func _on_close_button_pressed():
	self.hide() # Hides the menu.
	menu_closed.emit()
