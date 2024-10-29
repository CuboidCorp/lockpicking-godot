extends Sprite2D

@export var lock : Node
@export var rotation_speed: float = 0.2
@export var max_health: int = 100

var rotation_limit_left: int
var rotation_limit_right: int
var previous_mouse_x: float = 0.0
var current_health: int
var is_unlocking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	previous_mouse_x = get_viewport().get_mouse_position().x
	rotation_limit_left = lock.BOBBY_ROTATION_ZONE / -2
	rotation_limit_right = lock.BOBBY_ROTATION_ZONE / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Debug"):
		lock.show_debug()
	if Input.is_action_pressed("Generate"):
		lock.generate(1)
		
	# Handle unlock action
	if Input.is_action_pressed("Unlock"):
		try_unlock()
	else:
		lock.rotation_speed = -lock.lock_rot_speed
	
	# Handle rotation through mouse movement
	handle_mouse_movement()

func handle_mouse_movement():
	var current_mouse_x = get_viewport().get_mouse_position().x
	var mouse_delta = current_mouse_x - previous_mouse_x
	
	if mouse_delta != 0:
		rotation_degrees = clamp(rotation_degrees + mouse_delta * rotation_speed, rotation_limit_left, rotation_limit_right)
	
	previous_mouse_x = current_mouse_x

func damage():
	current_health -=1
	if (current_health <=0):
		print("Death")

func try_unlock():
	# Check if the current angle is within the correct angle zone
	if rotation_degrees > lock.correct_angle - lock.correctness_zone / 2 and rotation_degrees < lock.correct_angle + lock.correctness_zone / 2:
		lock.rotation_speed = lock.lock_rot_speed
		lock.max_rot_angle = lock.BOBBY_ROTATION_ZONE / 2
	elif rotation_degrees > lock.correct_angle - lock.hint_zone / 2 and rotation_degrees < lock.correct_angle + lock.hint_zone / 2:
		lock.rotation_speed = lock.lock_rot_speed
		lock.max_rot_angle = lock.BOBBY_ROTATION_ZONE / 2 /2
	else:
		lock.rotation_speed = -lock.lock_rot_speed
		lock.max_rot_angle = 0

