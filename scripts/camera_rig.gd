extends Node3D

@onready var background_viewport = $BaseCamera/BackgroundViewportContainer/BackgroundViewport
@onready var foreground_viewport = $BaseCamera/ForegroundViewportContainer/ForegroundViewport

@onready var background_camera = $BaseCamera/BackgroundViewportContainer/BackgroundViewport/BackgroundCamera
@onready var foreground_camera = $BaseCamera/ForegroundViewportContainer/ForegroundViewport/ForegroundCamera

func _ready():
	RenderingServer.set_default_clear_color(Color.DODGER_BLUE)
	background_viewport.size = DisplayServer.window_get_size()
	foreground_viewport.size = DisplayServer.window_get_size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background_camera.global_transform = GameManager.player.camera_point.global_transform
	foreground_camera.global_transform = GameManager.player.camera_point.global_transform
