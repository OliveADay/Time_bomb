extends Sprite2D

var tapping = false
var knife = false
var tapped_once = false
signal stabbed

func _process(delta: float) -> void:
	if $Label.visible and Input.is_action_pressed("pick_up"):
		if not tapped_once:
			$stab.play()
			tapped_once = true
		stabbed.emit()
		visible = false
		
	if not tapping:
		$AnimationPlayer.play("idle")
		


func _on_timeto_drop_timeout() -> void:
	tapping = true
	$AnimationPlayer.play("tap")


func _on_knife_pickedup() -> void:
	knife = true


func _on_playerfinder_body_entered(body: Node2D) -> void:
	if knife:
		$Label.visible = true


func _on_world_reload() -> void:
	visible = true
	$Label.visible = false
	knife = false
	tapping = false


func _on_playerfinder_body_exited(body: Node2D) -> void:
	$Label.visible = false
