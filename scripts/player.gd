extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animation_player = $Model/Player/AnimationPlayer
@onready var model = $Model
@onready var camera_point = $CameraPoint

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/InteractLabel

var walking = false
var keys = 0

func _ready():
	GameManager.set_player(self)
	animation_player.set_blend_time("idle", "run", 0.2)
	animation_player.set_blend_time("run", "idle", 0.2)
	update_interactions()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		model.look_at(position + direction)
		
		if !walking:
			walking = true
			animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if walking:
			walking = false
			animation_player.play("idle")

	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		interact()


# Interaction methods
func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()


func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""

func interact():
	if all_interactions:
		var current_interaction = all_interactions[0]
		print("Interaction with " + current_interaction.interact_type)
		match current_interaction.interact_type:
			"Chest":
				if current_interaction.get_parent().open():
					keys = keys + 1
			"Door":
				if keys > 0 and current_interaction.get_parent().open():
					keys = keys - 1
