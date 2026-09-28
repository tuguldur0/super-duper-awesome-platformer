extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -650.0

var coins = 0
var won = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	# space works too now!!
	# and w!!
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_W)) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	# wasd
	if Input.is_key_pressed(KEY_A):
		direction = -1
	if Input.is_key_pressed(KEY_D):
		direction = 1
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# if you fall off you die lol
	if position.y > 800:
		get_tree().reload_current_scene()

	# press r to restart
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()


func add_coin():
	coins = coins + 1
	get_parent().get_node("CanvasLayer/Label").text = "Coins: " + str(coins)


func win():
	won = true
	get_parent().get_node("CanvasLayer/Label").text = "YOU WIN!!!! you got " + str(coins) + " coins\npress R to play again"
