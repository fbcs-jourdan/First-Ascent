extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ending_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://scenes/world_2d.tscn")
	




func _on_rock_area_entered(area: Area3D) -> void:
	Climb.can_climb = true
	print("MY NAME IS MATTHEW AND IM CLIMBING")


func _on_rock_area_exited(area: Area3D) -> void:
	Climb.can_climb = false
