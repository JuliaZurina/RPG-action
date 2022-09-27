extends KinematicBody2D

export var acceleration = 300
export var max_speed = 50
export var friction = 200
export var damage = 0.5

enum{
	IDLE,
	WONDER,
	CHASE 
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE

onready var deatheffectpath = preload("res://Effects/DeathEffect.tscn")
onready var fireaballgd = preload("res://Spells/FireBall.gd")
onready var PlayerDetectionZone = $PlayerDetect
onready var animate = $Sprite
onready var stat = $Stat


func _ready():
	animate.frame = 0
	animate.play("default")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		WONDER:
			pass
		CHASE:
			pass
			
func _on_HurtBox_area_entered(area):
	stat.health -= damage
	if stat.health <= 0:
		var deatheffect = deatheffectpath.instance()
		get_parent().add_child(deatheffect)
		deatheffect.position = global_position
		deatheffect.frame = 0
		deatheffect.play("default")
		queue_free()
	if area != null:
		animate.frame = 0
		animate.play("HitEffect")
		
func _on_HurtBox_area_exited(area):
	animate.play("default")


		
