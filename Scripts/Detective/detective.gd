extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var in_doorway = false
var tp_x = 0
var tp_y = 0

func _process(delta) -> void:
	# handle animations
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("FrontWalk")
	elif Input.is_action_just_released("ui_down"):
		$AnimatedSprite2D.play("FrontIdle")
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite2D.play("BackWalk")
	elif Input.is_action_just_released("ui_up"):
		$AnimatedSprite2D.play("BackIdle")
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("SideWalk")
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		$AnimatedSprite2D.play("SideIdle")
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("SideWalk")
		$AnimatedSprite2D.flip_h = false
		
	# handle player teleportation
	if in_doorway and Input.is_action_just_pressed("ui_accept"):
		position.x += tp_x
		position.y += tp_y
		in_doorway = false
		

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_lr := Input.get_axis("ui_left", "ui_right")
	if direction_lr:
		velocity.x = direction_lr * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var direction_ud := Input.get_axis("ui_up", "ui_down")
	if direction_ud:
		velocity.y = direction_ud * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_kitchen_door_body_entered(body: Node2D) -> void:
	in_doorway = true
	tp_y = -180
	tp_x = 90


func _on_cellar_door_body_entered(body: Node2D) -> void:
	in_doorway = true
	tp_y = 200
	tp_x = 0


func _on_kitchen_to_hallway_body_entered(body: Node2D) -> void:
	in_doorway = true
	tp_y = 180
	tp_x = -90


func _on_living_room_door_body_entered(body: Node2D) -> void:
	in_doorway = true
	tp_y = 0
	tp_x = 150


func _on_living_room_to_hallway_body_entered(body: Node2D) -> void:
	in_doorway = true
	tp_x = -150
	tp_y = 0


func _on_kitchen_door_body_exited(body: Node2D) -> void:
	in_doorway = false


func _on_cellar_door_body_exited(body: Node2D) -> void:
	in_doorway = false


func _on_living_room_door_body_exited(body: Node2D) -> void:
	in_doorway = false
