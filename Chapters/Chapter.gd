extends Node2D

var baloonScene = preload("res://examples/point_n_click_balloon/balloon.tscn")

@onready var mouse = $Mouse
@onready var baloon: PointNClickBaloon
@onready var hoverText: RichTextLabel = $UI/HoverText

var hoveredSelectable: Selectable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse.position = get_global_mouse_position()
	
	if !is_instance_valid(baloon) && hoveredSelectable != null:
		hoverText.text = "[center]" + "Talk to Zach"
	else:
		hoverText.text = ""


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
	
	baloon = baloonScene.instantiate()
	add_child(baloon)
	baloon.start(hoveredSelectable.dialog, hoveredSelectable.currentStart)
	hoverText.text = ""


func _on_mouse_area_entered(area):
	if area is Selectable:
		hoveredSelectable = area


func _on_mouse_area_exited(area):
	if area is Selectable:
		hoveredSelectable = null
