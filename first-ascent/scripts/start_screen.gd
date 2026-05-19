extends Node2D
@onready var cloud: TextureRect = $cloud


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cloud.global_position.x -= 5
	if cloud.global_position.x == -800:
		cloud.global_position.x = 1500


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Levels/2DWorld1.tscn")
	



func _on_quit_button_pressed() -> void:
	get_tree().quit()
