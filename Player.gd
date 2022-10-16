extends CharacterBody2D

@export var speed = 50.0
@export var input_weight = 0.01
@export_node_path(Node) var audio_manager

var direction: Vector2 = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	pass

func _physics_process(delta):

	direction.x = lerp(direction.x, Input.get_axis("left", "right"), input_weight)
	direction.y = lerp(direction.y, Input.get_axis("up", "down"), input_weight)

	if direction.length() > 1:
		direction = direction.normalized()

	velocity = direction * speed

	move_and_slide()
