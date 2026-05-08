extends RigidBody3D
@onready var left: MeshInstance3D = $left
@onready var sfx: AudioStreamPlayer = $SFX

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var body_area: Area3D = $body/body_area

@onready var right_hand: Node3D = $right/Sketchfab_Scene
@onready var left_hand: Node3D = $left/Sketchfab_Scene
@onready var skill_check: Node2D = $SkillCheck

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var right: MeshInstance3D = $right
@export var move_radius := 0.5
@export var pull_strength := 5
@export var wall_normal := Vector3.FORWARD # normal pointing OUT of wall
var right_grip_strength = clamp(100, 0, 150)
var left_grip_strength = clamp(100, 0, 150)
@onready var right_label: Label3D = $right/RightGripLabel
@onready var left_label: Label3D = $left/LeftGripLabel
@onready var right_bar: ProgressBar = $right/Node3D/SubViewport/right_bar
@onready var left_bar: ProgressBar = $left/Node3D2/SubViewport/left_bar

@onready var cam: Camera3D = $body/cam
@onready var body: MeshInstance3D = $body
@onready var col: CollisionShape3D = $CollisionShape3D
@onready var player: RigidBody3D = $"."

var can_climb := false
var right_limit
var left_limit
var upper_limit
var climbing := true
var right_selected := true
var left_selected = false
var right_center
var left_center



func _physics_process(_delta):
	# Pull into wall (toward the surface)
	apply_central_force(-wall_normal * pull_strength)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#right_hand.play_grab()
	right_limit = body.global_position.x - 1.5
	left_limit = body.global_position.x + 1.5
	upper_limit = body.global_position.y + 3
	update_limits()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	right_center = right.global_position
	left_center = left.global_position
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
	axis_lock_angular_x = true  # lock roll
	axis_lock_angular_z = true  # lock pitch

	# Add damping so small torques die out quickly.           // NEW
	angular_damp_mode = RigidBody3D.DAMP_MODE_REPLACE
	angular_damp = 8.0

	linear_damp_mode = RigidBody3D.DAMP_MODE_COMBINE
	linear_damp = 0.6

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = body.global_position.y
	body.global_position.x = (right.global_position.x + left.global_position.x) * 0.4
	var l_material = left.get_active_material(0)
	var r_material = right.get_active_material(0)
	if Climb.wind_blowing:
		update_limits()
		
	print("right hand attached: " + str(Climb.right_attached))
	print("left hand attached: " + str(Climb.left_attached))
	if not Climb.right_attached:
		right_grip_strength = clamp(right_grip_strength+1*delta,0, 150)
	if not Climb.left_attached:
		left_grip_strength = clamp(left_grip_strength+1*delta,0, 150)
	if right_grip_strength < 0:
		print("MY NAME IS MATTHEW AND YOU cant use ur right hand")
		if left_grip_strength < 0:
			Climb.has_grip = false
		
	if left_grip_strength < 0:
		print("MY NAME IS MATTHEW AND YOU cant use ur left hand")
		if right_grip_strength < 0:
			Climb.has_grip = false
	right_label.text = str(int(right_grip_strength))
	left_label.text = str(int(left_grip_strength))
	right_bar.value = int(right_label.text)
	left_bar.value = int(left_grip_strength)
	body.global_position.y = ((right.global_position.y + left.global_position.y) * 0.5)
	#body.global_position.x = ((right.global_position.x + left.global_position.x) * 0.08)
	col.global_position.y = body.global_position.y
	
	if Input.is_action_just_pressed("climb") and not climbing:
		climbing = true
		skill_check.visible = false
	elif Input.is_action_just_pressed("climb") and climbing:
		climbing = false
		skill_check.visible = true
	if not climbing:
		left_grip_strength = clamp(left_grip_strength,0, 150)
		right_grip_strength = clamp(right_grip_strength,0, 150)
	if climbing:
		if right_selected and Climb.left_attached:
			left_grip_strength = clamp(left_grip_strength-20*delta,0, 150)
			l_material.albedo_color = Color(1, 0, 0)
		else: 
			l_material.albedo_color = Color(1, 1, 1)
		if left_selected and Climb.right_attached:
			right_grip_strength = clamp(right_grip_strength-20*delta,0, 150)
			r_material.albedo_color = Color(1, 0, 0)
		else:
			r_material.albedo_color = Color(1, 1, 1)
		if Input.is_action_just_pressed("switch_right") and Climb.can_climb:
			right_selected = false
			left_selected = true
			Climb.right_attached = true
			Climb.left_attached = false
			_warp_mouse_to_hand(left)
			update_limits()
			sfx.play_sfx("grab")
			body.global_position.x = (right.global_position.x + left.global_position.x) * .5
			right_hand.play_grab()
			left_hand.play_release()
			
			
		if Input.is_action_just_pressed("switch_left") and Climb.can_climb:
			right_selected = true
			left_selected = false
			Climb.right_attached = false
			Climb.left_attached = true
			_warp_mouse_to_hand(right)
			update_limits()
			body.global_position.x = (right.global_position.x + left.global_position.x) * .5
			sfx.play_sfx("grab")
			right_hand.play_release()
			left_hand.play_grab()
			
		var mouse_pos = get_viewport().get_mouse_position()
		
		var rayStart : Vector3 = cam.project_ray_origin(mouse_pos)
		var direction : Vector3 = cam.project_ray_normal(mouse_pos)
		
		var plane := Plane(-cam.global_transform.basis.z, right.global_position)
		
		var intersection = plane.intersects_ray(rayStart, direction)
		
		if intersection and right_selected:
			right.global_position.y = intersection.y
			right.global_position.x = intersection.x
			if right.global_position.x < right_limit:
				right.global_position.x = right_limit
			elif right.global_position.x > body.global_position.x:
				right.global_position.x = body.global_position.x
			if right.global_position.y > upper_limit:
				right.global_position.y = upper_limit
			
		elif intersection and not right_selected:
			left.global_position.y = intersection.y
			left.global_position.x = intersection.x
			if left.global_position.x > left_limit:
				left.global_position.x = left_limit
			elif left.global_position.x < body.global_position.x:
				left.global_position.x = body.global_position.x
			if left.global_position.y > upper_limit:
				left.global_position.y = upper_limit
	if int(right_grip_strength) == 0 and int(left_grip_strength) == 0: 
		get_tree().change_scene_to_file("res://scenes/cutscene.tscn")
func _warp_mouse_to_hand(new_hand: MeshInstance3D) -> void:
	var screen_pos: Vector2 = cam.unproject_position(new_hand.global_transform.origin)
	Input.warp_mouse(screen_pos)


func update_limits():
	right_limit = body.global_position.x - 1.5
	left_limit = body.global_position.x + 1.5
	upper_limit = body.global_position.y + 3
	


func _on_skill_check_passed() -> void:
	left_grip_strength += 10
	right_grip_strength += 10
