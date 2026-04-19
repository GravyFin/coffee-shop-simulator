extends Node

@onready var music = $Music
@onready var sfx_high = $SFX_High
@onready var sfx_low = $SFX_Low

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	apply_audio_settings()
	music.play()

func apply_audio_settings():
	var bus_index = AudioServer.get_bus_index("Master")
	
	if GameManager.is_muted:
		AudioServer.set_bus_volume_db(bus_index, -80)
	else:
		var db = linear_to_db(GameManager.volume)
		AudioServer.set_bus_volume_db(bus_index, db)

func play_high():
	sfx_high.pitch_scale = randf_range(0.95, 1.05)
	sfx_high.play()

func play_low():
	sfx_low.pitch_scale = randf_range(0.95, 1.05)
	sfx_low.play()
