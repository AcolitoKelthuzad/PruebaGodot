extends Node

export (PackedScene) var Mob

var score

func _ready():
	randomize()
#	$Player.connect('hit', self, 'game_over')
	new_game()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.actualizar_puntaje(score)
	$HUD.show_message("Listos!")
	$Music.play()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()
	get_tree().call_group("mobs","queue_free")
	

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.offset=randi()
	var mob = Mob.instance()
	add_child(mob)
	var direccion = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position=$MobPath/MobSpawnLocation.position
	direccion+=rand_range(-PI/4,PI/4)
	mob.rotation=direccion
	mob.linear_velocity= Vector2(rand_range(mob.min_speed,mob.max_speed),0)
	mob.linear_velocity = mob.linear_velocity.rotated(direccion)
	


func _on_ScoreTimer_timeout():
	score+=1
	
	$HUD.actualizar_puntaje(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()



