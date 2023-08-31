extends Node2D



@onready var hoverText: Label = $UI/HoverText

var hoveredSelectable: Selectable
var currentDialog: Bonnie

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_tree().get_nodes_in_group("Selectable"):
		if is_ancestor_of(node):
			node.hovered.connect(_onSelectableHovered)
			node.unhovered.connect(_onSelectableUnhovered)


func _input(event):
	if event is InputEventMouseButton && event.get_button_index() == MOUSE_BUTTON_LEFT && event.pressed:
		if !is_instance_valid(hoveredSelectable):
			hoveredSelectable = null
		if hoveredSelectable != null:
			get_viewport().set_input_as_handled()
			startDialog()



func startDialog():
	hoverText.text = ""
	currentDialog = Bonnie.new()
	currentDialog.load_dialogue(hoveredSelectable.dialog.resource_path)




func _onSelectableHovered(area: Selectable):
	hoveredSelectable = area
	$UI/HoverText.text = "Look at " + hoveredSelectable.name

func _onSelectableUnhovered(area: Selectable):
	hoveredSelectable = null
	$UI/HoverText.text = ""
