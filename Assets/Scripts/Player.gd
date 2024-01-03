extends CharacterBody2D
class_name Player

const SPEED =  300.0
const JUMP_VELOCITY = -500.0

var idle = "idle"
var movement = "movement"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var checkpoint = 0
var arms = false
var legs = false
var grab = false

func _ready():
	GameManager.player = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if grab && Input.is_action_pressed("grab"):
		velocity.y = 0
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle jump.
	if legs:
		if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or grab):
			velocity.y = JUMP_VELOCITY
			if grab:
				if direction:
					velocity.x = direction * SPEED
					
				else:
					velocity.x = move_toward(velocity.x, 0, SPEED)
				
	decide_animation()
	move_and_slide()

func decide_animation():
	if grab:
		$animaciones.play("grab")
	else:
		if velocity.x == 0:
			$animaciones.play(idle)
		elif velocity.x < 0:
			$animaciones.flip_h = true
			$animaciones.play(movement)
		else:
			$animaciones.flip_h = false
			$animaciones.play(movement)

func change_animation():
	if GameManager.checkpoints == 1:
		legs = true
		idle = "idlep2"
		movement = "movementp2"
		
		$colisionp1.set_deferred("disabled",true)
		$areap1/CollisionPolygon2D.set_deferred("disabled",true)
		
		$colisionp2.set_deferred("disabled",false)
		$areap2/colisionp2.set_deferred("disabled",false)
	elif GameManager.checkpoints == 2:
		arms = true
		idle = "idlep3"
		movement = "movementp3"

func die():
	$AudioStreamPlayer2D.play()
	GameManager.respawn_player()
