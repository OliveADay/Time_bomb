extends Area2D
signal pickedup
var play_once = false

func _process(delta: float) -> void:
	if $Label.visible:
		if Input.is_action_pressed("pick_up"):
			if not play_once:
				$pickup.play()
				play_once = true
			pickedup.emit()
			visible = false

func _on_body_entered(body: Node2D) -> void:
	$Label.visible = true


func _on_world_reload() -> void:
	$Label.visible = false
	visible = true


func _on_body_exited(body: Node2D) -> void:
	$Label.visible = false
