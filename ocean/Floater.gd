extends Node3D
class_name Floater

var depth_before_submerged = 1.0
@onready var ocean = get_node("/root/ocean")

var last_position = Vector3()

var floater_count = 0

@export var water_drag = 0.99
@export var water_angular_drag = 0.5

@export var enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent_weight = get_parent().weight
	# How many floater children does the parent have?
	for c in get_parent().get_children():
		if c.get_script() == get_script():
			floater_count += 1

func get_floater_position():
	return get_global_transform().origin

func _physics_process(delta):
	if not enabled:
		return
	
	# It had to be a world coord offset.... not just relative to the parent...
	# reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
	var world_coord_offset = get_floater_position() - get_parent().position
	
	# Gravity
	get_parent().apply_force(world_coord_offset, Vector3.DOWN * 9.8)
	
	var wave = ocean.get_wave(get_floater_position().x, get_floater_position().z)
	var wave_height = wave.y / 2.0
	var height = get_floater_position().y
	
	if height < wave_height:
		var buoyancy = clamp((wave_height - height) / depth_before_submerged, 0, 1) * 2
		get_parent().apply_force(world_coord_offset, Vector3(0, 9.8 * buoyancy, 0))
		get_parent().apply_central_force(buoyancy * -get_parent().linear_velocity * water_drag)
		get_parent().apply_torque(buoyancy * -get_parent().angular_velocity * water_angular_drag)
	if $Marker: $Marker.position.y = wave_height
