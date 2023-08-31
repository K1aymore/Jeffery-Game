extends Node2D


@onready var mouse = $Mouse
@onready var baloon
@onready var hoverText: Label = $UI/HoverText

var hoveredSelectable: Selectable

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_tree().get_nodes_in_group("Selectable"):
		if is_ancestor_of(node):
			node.hovered.connect(_onSelectableHovered)
			node.unhovered.connect(_onSelectableUnhovered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/HoverText.text = "Look at " + hoveredSelectable.name if hoveredSelectable != null else ""


func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == MOUSE_BUTTON_LEFT && event.pressed:
		if !is_instance_valid(hoveredSelectable):
			hoveredSelectable = null
		if hoveredSelectable != null:
			get_viewport().set_input_as_handled()
			startDialog()


func isInDialog() -> bool:
	return baloon.isVisible()


func startDialog():
	if is_instance_valid(baloon):
		return
	
	hoverText.text = ""



func _onSelectableHovered(area: Selectable):
	print("hey")
	hoveredSelectable = area

func _onSelectableUnhovered(area: Selectable):
	hoveredSelectable = null
