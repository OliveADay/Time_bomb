extends RigidBody2D
var explode = false
var base_pos = Vector2(3728.0,-504.0)

func _process(delta: float) -> void:
	if explode and $blast.scale.x < 10000000:
		$blast.scale *= 1.5
		

func _on_timeto_drop_timeout(anim_name:StringName) -> void:
	if anim_name == 'tap':
		gravity_scale = 1
		$fall.play()
		print('let go')
func _on_area_2d_body_entered(body: Node2D) -> void:
	explode = true
	$blast.visible = true
	print("hit ground")
	$boom.play()


func _on_world_reload() -> void:
	gravity_scale =-1
	explode = false
	$blast.scale = Vector2(1,1)
	$blast.visible = false
	


func _on_topfind_body_entered(body: Node2D) -> void:
	gravity_scale = 0
