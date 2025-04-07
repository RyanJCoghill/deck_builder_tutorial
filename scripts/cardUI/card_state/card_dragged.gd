extends CardState

const MIN_DRAG := 0.05

var min_drag_passed := false


func enter() -> void:
    var ui_layer = get_tree().get_first_node_in_group("UI_layer")
    if ui_layer:
        card_ui.reparent(ui_layer)
        
    card_ui.color.color = Color.BLUE
    card_ui.state.text = "Dragging"
    
    min_drag_passed = false
    var min_drag_timer := get_tree().create_timer(MIN_DRAG, false)
    min_drag_timer.timeout.connect(func(): min_drag_passed = true)
    

func on_input(event: InputEvent) -> void:
    var mouse_motion := event is InputEventMouseMotion
    var cancel = event.is_action_pressed('right_mouse')
    var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("Left_mouse")
    
    if mouse_motion:
        card_ui.global_position=card_ui.get_global_mouse_position() - card_ui.pivot_offset
        
    if cancel:
        transition_requested.emit(self, CardState.State.BASE)
    elif min_drag_passed and confirm:
        get_viewport().set_input_as_handled()
        transition_requested.emit(self, CardState.State.RELEASED)
