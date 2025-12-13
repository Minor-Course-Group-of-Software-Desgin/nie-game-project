extends Control

# 追踪菜单的实时位置和大小
var menu_origin_position := Vector2.ZERO
var menu_origin_size := Vector2.ZERO

# 当前菜单(object)
var current_menu
# 菜单栈
var menu_stack := []
# 动画对象
var animation :Node = null

# 创建menu的引用
@onready var menu_1 = $Menu1
@onready var menu_2 = $Menu2
# 创建对动画的引用 
@onready var transition_animation = $TransitionAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 获取菜单参数
	menu_origin_position = Vector2(0, 0)
	menu_origin_size = get_viewport_rect().size
	current_menu = menu_1
	# 获取过渡动画
	animation = transition_animation.get_node("AnimationPlayer")

# 菜单间的切换
# 本质上是 viewpoint不变 更改菜单的global_position
func move_to_next_menu(next_menu_id: String):
	var next_menu = get_menu_from_menu_id(next_menu_id)
	
	animation.play("transition_out")
	await animation.animation_finished
	
	# 先切换菜单位置
	current_menu.global_position = Vector2(-menu_origin_size.x, 0)
	next_menu.global_position = menu_origin_position
	menu_stack.append(current_menu)
	current_menu = next_menu
	animation.play_backwards("transition_out")

# 菜单返回
# 直接pop即可
func move_to_previous_menu():
	
	var previous_menu = menu_stack.pop_back()	
	
	animation.play("transition_out")
	await animation.animation_finished
	
	# 切换菜单位置
	previous_menu.global_position = menu_origin_position
	current_menu.global_position = Vector2(menu_origin_size.x, 0)
	current_menu = previous_menu
	
	animation.play_backwards("transition_out")

	

func get_menu_from_menu_id(menu_id: String) -> Control:
	match menu_id:
		"menu_1":
			return menu_1
		"menu_2":
			return menu_2
		_:
			return menu_1

func _on_button_pressed() -> void:
	move_to_next_menu("menu_2")

func _on_button_4_pressed() -> void:
	move_to_previous_menu()
