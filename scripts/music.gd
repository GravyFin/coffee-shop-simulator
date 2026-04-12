extends Node

@onready var music = $Music

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
