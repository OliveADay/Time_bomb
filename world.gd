extends Node2D
signal reload

func _ready() -> void:
	$AudioStreamPlayer2D.play()

func Reload() -> void:
	$clock.visible = false
	$clock/CenterContainer.visible = false
	$clock/CenterContainer2.visible = false
	$clock/CenterContainer3.visible = false
	reload.emit()


func _on_player_win() -> void:
	$win_screen.visible = true
	$evilmcevil/AudioStreamPlayer2D.play()
	$bomb.gravity_scale = 0


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func _rewind() -> void:
	$Player/static.play()
	$bomb/boom.stream_paused = true
	$bomb/fall.stream_paused = true
	$clock.visible = true
	$Player/clock_blip.play()
	await get_tree().create_timer(0.5).timeout
	$clock/CenterContainer.visible = true
	$clock/CenterContainer2.visible = true
	$clock/CenterContainer3.visible = true
	$Player/clock_blip.play()
	$clock/AnimationPlayer.play("circle")
	var anim = await $clock/AnimationPlayer.animation_finished
	Reload()
