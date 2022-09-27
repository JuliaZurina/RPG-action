extends KinematicBody2D
const acceleration = 700
const max_speed = 80
const friction = 500

var velocity = Vector2.ZERO	
onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")
onready var purpleballpath = preload("res://Spells/PurplePowerBall.tscn")
onready var clonespellpath = preload("res://Spells/CloneSpell.tscn")

func _ready():
	animationtree.active = true
	
func spell_attack(delta):
	var purpleball = purpleballpath.instance()
	get_parent().add_child(purpleball)
	purpleball.position = $Node2D/Position2D.global_position
	purpleball.velocity = get_global_mouse_position() - purpleball.position
	
func spell_cast():
	var clonespell = clonespellpath.instance()
	get_parent().add_child(clonespell)
	clonespell.position = get_global_mouse_position()
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animationtree.set("parameters/Idle/blend_position",input_vector)
		animationtree.set("parameters/Run/blend_position",input_vector)
		animationstate.travel("Run")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animationstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("shoot"):
		$Node2D.look_at(get_global_mouse_position())
		spell_attack(delta)
		
	if Input.is_action_just_pressed("Spellcast_1"):
		$Node2D.look_at(get_global_mouse_position())
		spell_cast()
