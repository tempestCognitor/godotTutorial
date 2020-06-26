extends Node2D


export (PackedScene) var Mouse
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# new_bumpats()


func bumpats_over():
	$AnockTimer.stop()
	$MouseTimer.stop()
	$IncredibleLumHunt.show_bumpats_over()
	get_tree().call_group("Mice", "queue_free")
	$LumMusic.stop()
	$BumSound.play()


func new_bumpats():
	score = 0
	$SlapYourMammy.start($StartPosition.position)

	$IncredibleLumHunt.update_anock_label(score)
	$IncredibleLumHunt.show_lumble("Get Ready")

	$ZaiTimer.start()
	$LumMusic.play()


func _on_ZaiTimer_timeout():
	$AnockTimer.start()
	$MouseTimer.start()


func _on_AnockTimer_timeout():
	score += 1
	$IncredibleLumHunt.update_anock_label(score)

	if score == 25:
		$MouseTimer.set_wait_time(0.25)


func _on_MouseTimer_timeout():
	var spawn_point = $MicePath/MouseHole
	spawn_point.offset = randi()

	var mouse = Mouse.instance()
	add_child(mouse)

	var direction = spawn_point.rotation + PI / 2
	mouse.position = spawn_point.position
	direction += rand_range(-PI / 4, PI / 4)
	mouse.rotation = direction

	mouse.linear_velocity = Vector2(rand_range(mouse.min_speed, mouse.max_speed), 0)
	mouse.linear_velocity = mouse.linear_velocity.rotated(direction)
