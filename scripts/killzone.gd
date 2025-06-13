extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5 # 设置游戏时间流逝为0.5倍，实现死亡慢放
	body.get_node("CollisionShape2D").queue_free() # 移除角色碰撞箱
	timer.start() # 触发timer计时器


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0 # 恢复正常时间流逝速度
	get_tree().reload_current_scene() # 重新加载当前场景
