extends RigidBody2D

onready var area = $Area2D

var speed = 0
var direction = 0
var is_rewind = false
var max_speed = 100
onready var is_on_table = 10
var target = null

func _physics_process(delta):
	if is_on_table > 0:
		if target == null:
			target = find_target()
			
		apply_central_impulse(Vector2(5,0).rotated(rotation))
		
		if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
			var new_speed = get_linear_velocity().normalized()
			new_speed *= max_speed
			set_linear_velocity(new_speed)
			
		var avoid = find_avoid()
			
		var d
		if avoid == null:
			var angle1 = rad2deg(global_position.angle_to_point(target.global_position))
			var angle2 = rotation_degrees
			d = angle_difference(angle1, angle2)
		else:
			var angle1 = rad2deg(global_position.angle_to_point(target.global_position))
			var angle2 = rotation_degrees
			d = angle_difference(angle1, angle2) -180
	
		if d < 0:
			apply_torque_impulse(-20)
		else:
			apply_torque_impulse(20)
		
	var check = true
	for a in area.get_overlapping_areas():
		if a.is_in_group("Ground"):
			check = false
			break
			
	if check:
		is_on_table -= 1
		
	if is_on_table <= 0:
		z_index = -1
		gravity_scale = 2

	
func find_target():
	var list = get_tree().get_nodes_in_group("Target")
	if list.size() > 0:
		return list[0]
		
func find_avoid():
	for a in area.get_overlapping_areas():
		if a.is_in_group("Avoid"):
			return a
	
	
static func angle_to_angle(from, to):
    return fposmod(to-from + PI, PI*2) - PI

func angle_difference(angle1, angle2):
    var diff = angle2 - angle1
    return diff if abs(diff) < 180 else diff + (360 * -sign(diff))