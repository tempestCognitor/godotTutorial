extends CanvasLayer


signal startpats


func _ready():
	pass # Replace with function body.


func show_lumble(text):
	$Lumble.text = text
	$Lumble.show()
	$LumbleTimer.start()


func show_bumpats_over():
	show_lumble("Game Over")

	yield($LumbleTimer, "timeout")

	$Lumble.text = "Dodge the Mice!"
	$Lumble.show()

	yield(get_tree().create_timer(1), "timeout")
	$Bumstartpat.show()


func update_anock_label(score):
	$AnockLabel.text = str(score)


func _on_LumbleTimer_timeout():
	$Lumble.hide()


func _on_Bumstartpat_pressed():
	$Bumstartpat.hide()
	emit_signal("startpats")