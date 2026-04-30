extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var retry: Control = $Retry

var play_counter = 0
var change_scene = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("playerfall")
	play_counter += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not animation_player.is_playing() and play_counter == 1:
		retry.visible = true
		

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Tester3D.tscn")
