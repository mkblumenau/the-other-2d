extends StaticBody2D
@export var initialPosition: Vector2 = Vector2(0, 0)
@export var finalPosition: Vector2 = Vector2(0, 0)
@export var clockObject: Control #Add the clock to this in Inspector to make this work.

# Called when the node enters the scene tree for the first time.
func _ready():
	#clockObject = get_node("Clock")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var positionDifference = finalPosition - initialPosition
	var newPosition = initialPosition + positionDifference * clockObject.time
	set_position(newPosition)
	pass

