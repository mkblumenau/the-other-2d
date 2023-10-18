extends RigidBody2D

#@export var speed = 10
# For the forward movement, just check RigidBody2D > Linear > Velocity.
@export var jumpStrength = 10
var global_variables
var isMoving = true # Turn this off to disable moving forward/jumping.
var hasKey = false
var collision_pos : Vector2 = Vector2(0.0, 0.0)

@export_category("Sound effects")
@export var jumpSound: AudioStream
@export var deathSound: AudioStream
@export var goalSound: AudioStream
@export var keySound: AudioStream


# Called when the node enters the scene tree for the first time.
func _ready():
	global_variables = get_node("/root/GlobalVariables")
	#playSound(deathSound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	"""
	var currentPosition = get_position()
	var newPosition = currentPosition + Vector2(speed * delta, 0)
	set_position(newPosition)
	"""
	
	# Reset the level if the player falls off the screen.
	if position.y > get_viewport().size.y:
		#global_variables.startCurrentScene()
		resetLevelAfterCollision()
	pass


func _physics_process(delta):
	"""
	if Input.is_action_just_pressed("Jump"):
		#apply_impulse(Vector2(0, jumpStrength))
		set_axis_velocity(Vector2(0, jumpStrength))
		#set_axis_velocity(linear_velocity + Vector2(0, jumpStrength))
		print("Jump")
	print(linear_velocity)
	"""
	pass


func _integrate_forces(state):
	# Forward motion is added by changing the linear velocity in Inspector.
	# Also, set Damp Mode to Replace and Damp to 0.
	
	"""
	if state.get_contact_count() > 0:
		collision_pos = to_local(state.get_contact_local_position(0))
	"""
	
	#Old way to add forward motion.
	#state.apply_force(Vector2(speed, 0))
	if not isMoving:
		linear_velocity = Vector2(0, 0)
		
	# If the player runs into something on the right, their motion comes to a stop.
	# In that case, reset the level.
	if linear_velocity.normalized() == Vector2(0, 0) and isMoving:
		print("fail")
		resetLevelAfterCollision()
	
	# Jump if the player is touching the ground.
	if Input.is_action_just_pressed("Jump") and isTouchingGround() and isMoving:
		state.apply_impulse(Vector2(0, -jumpStrength))
		$AnimatedSprite2D.play("jump_simple")
		playSound(jumpSound)
		#state.set_axis_velocity(Vector2(0, jumpStrength))
		#set_axis_velocity(linear_velocity + Vector2(0, jumpStrength))
		print("Jump")
	#print(linear_velocity)
	pass


func _on_body_entered(body):
	# When this collides with another body.
	
	#var positionDifference = body.position - position 
	#positionDifference = positionDifference.normalized()
	#print(positionDifference)
	
	#print(collision_pos)
	
	"""
	if body.position.x - position.x > 0 and not body.get_collision_layer_value(4):
		print("Right collision")
		resetLevelAfterCollision()
	"""
	if body.get_collision_layer_value(1): # ground layer
		print("Ground collision")
	if body.get_collision_layer_value(3): # enemy layer
		print("Enemy collision")
		resetLevelAfterCollision()
	if body.get_collision_layer_value(4): # goal layer
		print("Goal collision")
		nextLevelAfterCollision()


func isTouchingGround():
	""" Return whether or not this is touching a scene layer object. """
	for b in get_colliding_bodies():
		if b.get_collision_layer_value(1):
			return true
			
	return false


func resetLevelAfterCollision():
	""" Call this to reset the level after a collision. """
	
	# This makes sure the sound only plays once.
	if isMoving:
		playSound(deathSound)
		isMoving = false
	
	# Only start the waiting timer if it's not already going.
	if $LevelResetTimer.is_stopped():
		$LevelResetTimer.start()
	await $LevelResetTimer.timeout
	global_variables.startCurrentScene()


func nextLevelAfterCollision():
	""" Call this to go to the next level after a collision,
	specifically when the player touches the goal. """
	if isMoving:
		playSound(goalSound)
		isMoving = false
	
	$LevelResetTimer.start()
	await $LevelResetTimer.timeout
	global_variables.startNextScene()


func playSound(source):
	if global_variables.soundOn:
		$AudioStreamPlayer.set_stream(source)
		$AudioStreamPlayer.play()


func getKey():
	hasKey = true
	playSound(keySound)


func _on_key_check_area_body_entered(body):
	# Detects the key.
	# This is from a signal from an Area2D that's separate from the main Rigidbody,
	# so the key won't stop the player moving.
	# This is also used to detect the gate.
	if body.get_collision_layer_value(5): # key
		print("Key collision")
		body.queue_free() # Delete that object.
		getKey()
	if body.get_collision_layer_value(6): # gate
		print("Gate")
		if not hasKey:
			resetLevelAfterCollision()
	pass # Replace with function body.

