extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mountain_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/Tester3D.tscn")
	


	
func _on_friend_2_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://will.dialogue"), "start")

func _on_friend_3_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://mason.dialogue"), "start")

func _on_friend_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://matthew.dialogue"), "start")
