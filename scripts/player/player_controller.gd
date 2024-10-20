extends Node2D

@onready var character = $Character
@onready var camera = $Camera

func _ready():
	# Ensure the camera gets a reference to the character since the loading is inconsitent.
	camera.player = character
