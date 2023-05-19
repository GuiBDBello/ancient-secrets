extends CSGBox3D

var layer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.player.position.x > position.x:
		set_to_background()
	else:
		set_to_foreground()

func set_to_background():
	if layer != 2:
		layer = 2
		set_layer_mask_value(1, true)
		set_layer_mask_value(2, false)

func set_to_foreground():
	if layer != 1:
		layer = 1
		set_layer_mask_value(1, false)
		set_layer_mask_value(2, true)
