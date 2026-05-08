extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_friend_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mom.dialogue"), "start")
	Climb.can_move = false


	
func _on_dialogue_ended(t):
	print(t)
	Climb.can_move = true


func _on_friend_2_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dad.dialogue"), "start")
	Climb.can_move = false


func _on_mountain_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/Levels/Level2.tscn")


func _on_friend_3_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/hiker6.dialogue"))
	Climb.can_move = false

#
#func _on_mountain_2_body_entered(body: Node2D) -> void:
	#get_tree().change_scene_to_file()
