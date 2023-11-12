""" This script handles listing the scenes in order as well as changing between them. """

extends Node

@export var scenesList: Array # Add the filepaths of all scenes in order to this.
var currentScene = 0
#var soundOn = true
var SFXBus = AudioServer.get_bus_index("SFX")
signal sound_toggled (newState) # This was previously in the code, but I don't think it's needed.


# Called when the node enters the scene tree for the first time.
func _ready():
	#print(get_viewport().size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func startScene(sceneNumber):
	""" Starts the scene that's that number in scenesList. """
	currentScene = sceneNumber
	startCurrentScene()


func startCurrentScene():
	""" Starts the scene that currentScene is set to now.
	Call this to reload the scene that the game is currently on. """
	get_tree().change_scene_to_file(scenesList[currentScene])
	pass


func startNextScene():
	""" Starts the scene after the current one. """
	currentScene += 1
	startCurrentScene()


""" Use these functions to turn the sound on and off.
They emit a signal that can be used for controlling a UI element. """

func isSFXMuted():
	return AudioServer.is_bus_mute(SFXBus)


func toggleSFXMute():
	AudioServer.set_bus_mute(SFXBus, not isSFXMuted())


func flipSoundOn():
	toggleSFXMute()
	#sound_toggled.emit(isSFXMuted())


func setSoundOn(newState):
	AudioServer.set_bus_mute(SFXBus, not newState)
	#sound_toggled.emit(isSFXMuted())


func soundOn():
	# This exists mostly for backwards compatibility.
	# Basically I originally wrote the code with a different system,
	# and after changing it I put this in to make changing the rest of the code easier.
	return not isSFXMuted()
