extends AudioStreamPlayer

var grab = preload("res://assets2D/sound/garb sound.mp3")

#func _ready() -> void:
	#set_volume_db(-20)

# Called when the node enters the scene tree for the first time.
func play_sfx(sfx_name : String):
	var stream = null
	if sfx_name == "grab":
		stream = grab
		
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	add_child(asp)
	asp.play()
