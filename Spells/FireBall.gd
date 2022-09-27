extends KinematicBody2D
onready var ani_sprite = $Sprite
export (float) var damage = 0.5
onready var total_damage = damage
var velocity = Vector2.ZERO
var speed = 150

func _physics_process(delta):
	ani_sprite.play("default")
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
		
	if collision_info != null:
		speed = 5
		ani_sprite.frame = 0
		ani_sprite.play("HitEffect")

func _on_Timer_timeout():
	queue_free()
