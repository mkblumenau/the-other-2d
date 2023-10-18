extends Control

var radiansPerRotation = PI
var time = 0
@export var speed = 0.4 # How fast the clock hand rotates.
var global_variables


# Called when the node enters the scene tree for the first time.
func _ready():
	global_variables = get_node("/root/GlobalVariables")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move the clock hand according to the inputs,
	# or react to any other input.
	if Input.is_anything_pressed():
		if Input.is_action_pressed("Time forward"):
			timeChange(speed * delta)
		if Input.is_action_pressed("Time backward"):
			timeChange(-speed * delta)
		if Input.is_action_just_pressed("Reset level"):
			global_variables.startCurrentScene()
		if Input.is_action_just_pressed("Toggle sound"):
			global_variables.flipSoundOn()
		if Input.is_action_just_pressed("Return to main menu"):
			global_variables.startScene(0)
	#print(time)


func timeChange(amountToChange):
	# Changes the time and updates the rotation of the clock hand.
	time += amountToChange
	time = clamp(time, 0, 1) # Make sure time doesn't go below 0 or over 1.
	$ClockHand.rotation = radiansPerRotation * time
