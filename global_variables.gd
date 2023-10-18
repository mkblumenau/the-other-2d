""" This script handles listing the scenes in order as well as changing between them. """

extends Node

@export var scenesList: Array # Add the filepaths of all scenes in order to this.
var currentScene = 0
var soundOn = true
signal sound_toggled (newState)


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


""" Use these functions to change soundOn.
They emit a signal that can be used for controlling a UI element. """

func flipSoundOn():
	soundOn = !soundOn
	sound_toggled.emit(soundOn)


func setSoundOn(newState):
	soundOn = newState
	sound_toggled.emit(soundOn)
