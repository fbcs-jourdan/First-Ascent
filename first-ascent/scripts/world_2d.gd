extends Node2D

@onready var exclamation_1: Sprite2D = $exclamation1
@onready var exclamation_2: Sprite2D = $exclamation2
@onready var exclamation_3: Sprite2D = $exclamation3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mountain_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/Tester3D.tscn")
	


	
func _on_friend_2_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/will.dialogue"), "start")
	Climb.can_move = false
	
func _on_friend_3_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mason.dialogue"), "start")
	Climb.can_move = false
	
func _on_friend_body_entered(body: Node2D) -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/matthew.dialogue"), "start")
	#DialogueManager.emit_signal("dialogue_ended")
	Climb.can_move = false

func _on_friend_body_exited(body: Node2D) -> void:
	Climb.can_move = true
	exclamation_1.visible = false
	

func _on_friend_2_body_exited(body: Node2D) -> void:
	Climb.can_move = true
	exclamation_2.visible = false

func _on_friend_3_body_exited(body: Node2D) -> void:
	Climb.can_move = true
	exclamation_3.visible = false
	
func _on_dialogue_ended(t):
	print(t)
	Climb.can_move = true
