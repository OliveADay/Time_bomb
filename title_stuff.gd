extends Node2D
var world = preload("res://world.tscn").instantiate()


func _on_play_pressed() -> void:
	add_child(world)
	$main.visible = false
	$AudioStreamPlayer2D.play()


func _on_instructions_pressed() -> void:
	$instructions.visible = true
	$AudioStreamPlayer2D.play()
	



func _on_back_pressed() -> void:
	$instructions.visible = false
	$AudioStreamPlayer2D.play()
