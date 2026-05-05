extends Node2D
@onready var goodzone: MeshInstance2D = $goodzone
@onready var tick: MeshInstance2D = $tick
@onready var badzone: MeshInstance2D = $badzone

var moving_right = true
var moving_left = false

var failing = true
var passing = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goodzone.modulate = Color(1, 0, 0)
	tick.modulate = Color()
	#DisplayServer.window_set_size()
	get_window().size = Vector2i(640, 480)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(goodzone.global_position.x)
	if moving_right:
		tick.global_position.x += 1000 * delta
		if tick.global_position.x >= goodzone.global_position.x + goodzone.scale.x/2 - 10:
			moving_left = true
			moving_right = false
	elif moving_left:
		tick.global_position.x -= 1000 * delta
		if tick.global_position.x <= badzone.global_position.x - badzone.scale.x/2:
			moving_left = false
			moving_right = true
	#print("failing: " + str(failing))
	#print("passing: " + str(passing))
	if Input.is_action_just_pressed("skillcheck"):
		if failing:
			print("you missed")
			goodzone.scale.x = 216.999954223633
			goodzone.global_position.x = 615
		elif passing:
			Climb.grip_value += 10
			goodzone.scale.x -= 20
			goodzone.global_position.x -= 10 	



func _on_goodzone_area_entered(area: Area2D) -> void:
	passing = true


func _on_goodzone_area_exited(area: Area2D) -> void:
	passing = false


func _on_badzone_area_entered(area: Area2D) -> void:
	failing = true


func _on_badzone_area_exited(area: Area2D) -> void:
	failing = false
