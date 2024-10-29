extends Node2D

var lockpickScene = preload("res://Scenes/lockpicking_minigame.tscn")
var lockpick_instance : Node

@export var status_text : RichTextLabel  

var is_lockpicking : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Start") and is_lockpicking == false : 
		is_lockpicking = true
		lockpick_instance = lockpickScene.instantiate()
		lockpick_instance.set_offset(Vector2(575,300))
		lockpick_instance.get_node("Lock").lock_opened.connect(_on_lockpick_successful)
		add_child(lockpick_instance)
	if Input.is_action_just_pressed("Return") and is_lockpicking:
		is_lockpicking = false
		lockpick_instance.queue_free()
		status_text.set_text("[center]Returned[/center]")
	pass

func _on_lockpick_successful():
	is_lockpicking = false
	lockpick_instance.queue_free()
	status_text.set_text("[center]Success[/center]")
	pass
