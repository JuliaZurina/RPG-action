extends KinematicBody2D

onready var animatedsprite = $AnimatedSprite
onready var animatedsprite2 = $AnimatedSprite2
onready var animatedsprite3 = $AnimatedSprite3


func _ready():
	animatedsprite.frame = 0
	animatedsprite.play("attack")
	animatedsprite2.play("attack")
	animatedsprite3.play("attack")

func _on_AnimatedSprite_animation_finished():
	animatedsprite.frame = 0
	animatedsprite.play("poof")
	animatedsprite2.play("poof")
	animatedsprite3.play("poof")
	
func _on_Timer_timeout():
	queue_free()



