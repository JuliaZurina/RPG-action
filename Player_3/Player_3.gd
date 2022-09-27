extends KinematicBody2D
const acceleration = 700
const max_speed = 80
const friction = 500
var fireballpath = preload("res://Spells/FireBall.tscn")
var firespellpath = preload("res://Spells/FireSpell.tscn")
var icespellpath = preload("res://Spells/IceSpell.tscn")
const cooldown = preload("res://Scripts/Cooldown.gd")

onready var game_timer = OS.get_ticks_msec()
onready var fireball_cooldown = cooldown.new(0.3)
onready var firespell_cooldown = cooldown.new(5)

var velocity = Vector2.ZERO
var state = MOVE
onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")

enum{
	MOVE,
	ATTACK,
	ROLL
}
func _physics_process(delta):
	fireball_cooldown.tick(delta)
	firespell_cooldown.tick(delta)
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			pass
		ROLL:
			pass


func _ready():
	animationtree.active = true
	
func get_time():
	var current_time = OS.get_ticks_msec() - game_timer
	var seconds = current_time/1000%60
	return str(seconds)
	
func spell_cast():
	var firespell = firespellpath.instance()
	get_parent().add_child(firespell)
	firespell.position = get_global_mouse_position()

func ice_spell_cast():
	var icespell = icespellpath.instance()
	get_parent().add_child(icespell)
	icespell.position = get_global_mouse_position()

func spell_attack():
	var fireball = fireballpath.instance()
	get_parent().add_child(fireball)
	fireball.position = $Node2D/Position2D.global_position
	fireball.velocity = get_global_mouse_position() - fireball.position
	
func move_state(delta):
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


	if Input.is_action_just_pressed("shoot") and fireball_cooldown.is_ready():
		$Node2D.look_at(get_global_mouse_position())
		spell_attack()
		
	
	if Input.is_action_just_pressed("Spellcast_1") and firespell_cooldown.is_ready():
		$Node2D.look_at(get_global_mouse_position())
		spell_cast()

	if Input.is_action_just_pressed("Spellcast_2"):
		$Node2D.look_at(get_global_mouse_position())
		ice_spell_cast()
		


