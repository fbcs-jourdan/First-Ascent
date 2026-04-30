extends Node2D

@onready var goodzone: Area2D = $goodzone
@onready var tick: Area2D = $tick

var moving_right = true
var moving_left = false

var failing = true
var passing = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goodzone.modulate = Color(1, 0, 0)
	tick.modulate = Color()
	#DisplayServer.window_set_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving_right:
		tick.global_position.x += 1000 * delta
		if tick.global_position.x >= 730:
			moving_left = true
			moving_right = false
	if moving_left:
		tick.global_position.x -= 1000 * delta
		if tick.global_position.x <= 45:
			moving_left = false
			moving_right = true
	#print("failing: " + str(failing))
	#print("passing: " + str(passing))
	if Input.is_action_just_pressed("skillcheck"):
		if failing:
			print("you missed")
		elif passing:
			print("you passed")	


func _on_badzone_body_entered(body: Node2D) -> void:
	failing = true
	
func _on_badzone_body_exited(body: Node2D) -> void:
	failing = false
	
func _on_goodzone_body_entered(body: Node2D) -> void:
	passing = true
#
func _on_goodzone_body_exited(body: Node2D) -> void:
	passing = false
