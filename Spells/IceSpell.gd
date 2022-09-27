extends KinematicBody2D

onready var animatedsprite = $AnimatedSprite
onready var ani_player = $HitBox

func _ready():
	animatedsprite.frame = 0
	animatedsprite.play("IceSpell")

func _on_Timer_timeout():
	queue_free()
	
	

func _on_HitBox_area_entered(area):
	pass
	


func _on_AnimatedSprite_animation_finished():
	animatedsprite.frame = 0
	animatedsprite.play("IceSpell_Fade")
