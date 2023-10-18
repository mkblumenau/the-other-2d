extends Control


func _enter_tree():
	randomize()
	var newHue = randf()
	$CanvasLayer/ColorRect.color = Color.from_ok_hsl(newHue, 0.5, 0.3)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
