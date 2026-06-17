extends CharacterBody2D

# variables for movement
const SPEED = 150.0
const JUMP_VELOCITY = -5000
var gravity = 10000
var jumpBufferTimer = 0.0
const JUMP_BUFFER_TIME_THRESHOLD = 0.1

# Hayate super jump variables
var HayateSuperJump = 1
var superJumpLimiter = 0

func _physics_process(delta):
	if not is_on_floor():
		# make gravity exist
		velocity.y = gravity * delta
	else:
		# reset super jump
		superJumpLimiter = HayateSuperJump
	
	if Input.is_action_just_pressed("jump"):
		jumpBufferTimer = JUMP_BUFFER_TIME_THRESHOLD
	
	if jumpBufferTimer > 0:
		jumpBufferTimer -= delta
		
	if Input.is_action_just_pressed("jump"):
		if jumpBufferTimer > 0:
			if is_on_floor():
				velocity.y = JUMP_VELOCITY
				jumpBufferTimer = 0
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	# Hayate super jump activates when holding W and jumping
	if Input.is_action_pressed("HayateSuperJump") and Input.is_action_just_pressed("jump"):
		if HayateSuperJump > 0:
			if is_on_floor():
				velocity.y = JUMP_VELOCITY * 2
				HayateSuperJump -= 1
				jumpBufferTimer = 0
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 2 * delta)
	
	move_and_slide()
