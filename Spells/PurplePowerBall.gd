extends KinematicBody2D
var velocity = Vector2.ZERO
onready var spritepath = $AnimatedSprite
var speed = 150

func _physics_process(delta):
	spritepath.play("default")
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
		
	if collision_info != null:
		speed = 6
		spritepath.frame = 0
		spritepath.play("HitEffect")


func _on_Timer_timeout():
	queue_free()
