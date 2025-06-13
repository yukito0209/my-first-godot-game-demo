extends CharacterBody2D


const SPEED = 130.0 # 移动速度
const JUMP_VELOCITY = -300.0 # 跳跃速度

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor(): # 如果玩家没有站在平台上
		velocity += get_gravity() * delta # 通过重力使玩家下落

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 获取移动方向：-1，0，1
	var direction := Input.get_axis("move_left", "move_right")
	
	# 翻转立绘
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# 播放角色动画
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	# 执行移动
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
