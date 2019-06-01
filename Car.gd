extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("turn_left"):
		add_torque(-30)
	if Input.is_action_pressed("turn_right"):
		add_torque(30)
	if Input.is_action_pressed("acelerate"):
		add_force(Vector2(0,0), Vector2(10,0))