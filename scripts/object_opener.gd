extends Node3D

var isOpen = false

func open():
	if !isOpen:
		$AnimationPlayer.play("open")
		isOpen = true
	return isOpen
