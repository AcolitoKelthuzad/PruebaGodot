extends Area2D

signal hit

export var speed = 400
var screen_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocidad=Vector2().normalized()
	if Input.is_action_pressed("ui_right"):
		velocidad.x+=1
	if Input.is_action_pressed("ui_left"):
		velocidad.x-=1
	if Input.is_action_pressed("ui_up"):
		velocidad.y-=1
	if Input.is_action_pressed("ui_down"):
		velocidad.y+=1
	
	if velocidad.length()>0:
		velocidad=velocidad.normalized()*speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position+=velocidad*delta
	position.x=clamp(position.x,0,screen_size.x)
	position.y=clamp(position.y,0,screen_size.y)
	if velocidad.x!=0:
		$AnimatedSprite.animation="caminar"
		$AnimatedSprite.flip_v=false
		$AnimatedSprite.flip_h=velocidad.x<0
	elif velocidad.y!=0:
		$AnimatedSprite.animation="arriba"
		$AnimatedSprite.flip_v=velocidad.y>0

func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false

func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled",true)
#	call_deferred("set_monitoring",false)

#func new_game():
#	score = 0
#	$Player.start($StartPosition.position)
#	$StartTimer.start()
