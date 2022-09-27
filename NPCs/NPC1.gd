extends KinematicBody2D

onready var ani_sprite = $AnimatedSprite
onready var timer = $Timer
onready var speed = 30

enum{
	ROAM_RIGHT,
	ROAM_LEFT,
	IDLE
}
var state = ROAM_RIGHT

func _physics_process(delta):
	match state:
		ROAM_RIGHT:
			move_right(delta)
		ROAM_LEFT:
			move_left(delta)
		IDLE:
			pass
			
func move_right(delta):
	var velocity = Vector2(1,0)
	ani_sprite.flip_h = true
	ani_sprite.play("walkleft")
	var move = move_and_collide(velocity.normalized() * speed * delta)

func move_left(delta):
	timer.autostart = true
	var velocity = Vector2(-1,0)
	ani_sprite.flip_h = false
	var _move = move_and_collide(velocity.normalized() * speed * delta)
	if _move != null:
		velocity = Vector2(1,0)
		state = ROAM_RIGHT

func idle_state():
	pass
	
func _on_Timer_timeout():
	state = ROAM_LEFT 
