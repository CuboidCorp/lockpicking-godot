extends Sprite2D

@export var lock : Node
@export var rotation_speed: float = 0.1
@export var max_health:int = 100


var rotation_limit_left : int 
var rotation_limit_right : int
var previous_mouse_x: float = 0.0
var current_health:int

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	previous_mouse_x = get_viewport().get_mouse_position().x
	rotation_limit_left = lock.BOBBY_ROTATION_ZONE / -2
	rotation_limit_right = lock.BOBBY_ROTATION_ZONE / 2
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("Debug"):
		lock.show_debug()
	if Input.is_action_pressed("Generate"):
		lock.generate(1)
	if Input.is_action_pressed("Unlock"):
		try_unlock()
	handle_mouse_mouvement()
	
		
	pass

func handle_mouse_mouvement():
	var current_mouse_x = get_viewport().get_mouse_position().x
	var mouse_delta = current_mouse_x - previous_mouse_x
	
	if mouse_delta != 0:
		rotation_degrees = clamp(rotation_degrees + mouse_delta * rotation_speed, rotation_limit_left, rotation_limit_right)
	
	previous_mouse_x = current_mouse_x
	pass

func try_unlock():
	print("Try unlock")
	print("Angle : "+str(rotation_degrees))
	
	#Check if current angle is withing the correctness zone
	if(rotation_degrees > lock.correct_angle - lock.correctness_zone / 2 and rotation_degrees < lock.correct_angle + lock.correctness_zone / 2):
		print("Success")
	elif (rotation_degrees > lock.correct_angle - lock.hint_zone / 2 and rotation_degrees < lock.correct_angle + lock.hint_zone / 2) : 
		print("Almost")
	else :
		print("Fail")
		current_health -=1
		if(current_health <0):
			print("BREAK")
	pass
