extends CardState

var played: bool

func enter() -> void:
    card_ui.color.color = Color.WEB_PURPLE
    card_ui.state.text = "Released"
    
    played = false
    
    if not card_ui.targets.is_empty():
        played = true
        print("Played to targets:", card_ui.targets)

func on_input(_event: InputEvent) -> void:
    if played:
        return
    
    transition_requested.emit(self, CardState.State.BASE)
