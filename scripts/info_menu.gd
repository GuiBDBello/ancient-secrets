extends Control

@export var labelText = ""
@export var buttonText = ""
@export var nextScene = ""

@onready var label = $Background/CenterContainer/VBoxContainer/Label
@onready var button = $Background/CenterContainer/VBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	visible = false
	get_tree().paused = false
	if get_node("Background/CenterContainer/VBoxContainer/Button").text == "Restart":
		get_tree().reload_current_scene()
