extends RigidBody2D

onready var area = $Area2D

var speed = 0
var direction = 0

var max_speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var applied_max_speed = max_speed
	for body in area.get_overlapping_bodies():
		applied_max_speed -= body.mass
	if applied_max_speed < 0:
		applied_max_speed = 0
	
#	if Input.is_action_pressed("turn_left"):
#		direction -= 0.1 * (speed/max_speed)
#	if Input.is_action_pressed("turn_right"):
#		direction += 0.1 * (speed/max_speed)
#	if Input.is_action_pressed("acelerate"):
#		speed += 0.7
#	elif Input.is_action_pressed("break"):
#			speed -= 0.7
#	else:
#		if speed > 0:
#			speed *= 0.99
#
#	if speed > applied_max_speed:
#		speed = applied_max_speed
#
#	linear_velocity = Vector2(speed,0).rotated(direction)
#	rotation = direction
	if Input.is_action_pressed("acelerate"):
		apply_central_impulse(Vector2(10,0).rotated(rotation))
	if Input.is_action_pressed("break"):
		apply_central_impulse(-Vector2(10,0).rotated(rotation))
	if Input.is_action_pressed("turn_left"):
		apply_torque_impulse(-30)
	if Input.is_action_pressed("turn_right"):
		apply_torque_impulse(30)

	var force = linear_velocity
	apply_central_impulse(-force)
	var diference = angle_to_angle(rotation, force.angle())
	apply_central_impulse(force.rotated(-diference))
	
	
	
static func angle_to_angle(from, to):
    return fposmod(to-from + PI, PI*2) - PI