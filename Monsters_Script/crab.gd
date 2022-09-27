extends KinematicBody2D
onready var zombie_move = $Sprite

var player = null
var move = Vector2.ZERO

func _ready():
	zombie_move.play("Zombie_move_right")
func _physics_process(delta):
	move = Vector2.ZERO
	

