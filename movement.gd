extends CharacterBody2D
var left = false
var right = false
var down = false
var jump = false
var gravity = 0
var timer:Timer
var on_ladder = false
var grabbed_knife = false
var timerset = false
var default_pos = Vector2(108.0,-8.0)
var moveable = true
signal explosion_done
signal win
var max_time_to_next_walk = 20
var current_time_to_next_walk = 0
var max_time_to_next_climb = 20
var current_time_to_next_climb = 0
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	timer = get_tree().get_first_node_in_group("bombTimer")

		
func _physics_process(delta: float) -> void:
	if not $wind.playing:
		$wind.play()
	if moveable:
		if Input.is_action_pressed("left_mov"):
			if not timerset:
				timer.start()
				timerset = true
			left = true
			$AnimationPlayer.play("walk")
		if Input.is_action_pressed("right_mov"):
			if not timerset:
				timer.start()
				timerset = true
			right = true
			$AnimationPlayer.play("walk")
		if Input.is_action_pressed("up_mov") and on_ladder:
			jump = true
			$AnimationPlayer.play("walkback")
		else:
			jump = false
		if Input.is_action_pressed("down_mov") and on_ladder:
			down = true
			$AnimationPlayer.play("walkback")
		else:
			down = false
			
	if (right or left) and current_time_to_next_walk == 0:
		select_walk()
		current_time_to_next_walk = max_time_to_next_walk
	if (right or left) and current_time_to_next_walk > 0:
		current_time_to_next_walk -= 1
	if (not right) and (not left):
		current_time_to_next_walk = 0
	
	if (jump or down) and current_time_to_next_climb == 0:
		select_climb()
		current_time_to_next_climb = max_time_to_next_climb
	if (jump or down) and current_time_to_next_climb > 0:
		current_time_to_next_climb -=1
	if (not jump) and (not down):
		current_time_to_next_climb = 0
		
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("idle")
	
	var vel= Vector2(0,0)
	if left:
		vel.x = -50
		left = false
		$main.scale.x = -1
	if right:
		vel.x = 50
		$main.scale.x = 1
		right = false
	if jump:
		vel.y -= 50
	elif down:
		vel.y += 50
	else:
		vel.y = 0
	if is_on_floor() == false and not on_ladder:
		gravity += 5
		vel.y += gravity
	else:
		gravity = 0
	
	velocity = vel
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	on_ladder = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	on_ladder = false

func _on_explosionfinder_body_entered(body: Node2D) -> void:
	print("explosion done")
	#get_tree().reload_current_scene()
	explosion_done.emit()


func _on_knife_pickedup() -> void:
	grabbed_knife = true


func _on_evilmcevil_stabbed() -> void:
	$AnimationPlayer.play("stab")


func _on_world_reload() -> void:
	position = default_pos
	grabbed_knife = false
	gravity = 0
	left = false
	right = false
	jump = false
	down = false
	timerset = false
	on_ladder = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "stab":
		win.emit()
		moveable = false

func select_walk() -> void:
	var i = rng.randi_range(0,1)
	if i == 0:
		$walk_1.play()
	else:
		$walk_2.play()
		
func select_climb() -> void:
	var i = rng.randi_range(0,1)
	if i == 0:
		$climb_1.play()
	else:
		$climb_2.play()
