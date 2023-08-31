extends Area2D

class_name Selectable


@export var lookIcon := preload("res://Klaymore profile.png")

@export var dialog : Resource

signal hovered(node: Selectable)
signal unhovered(node: Selectable)





func _on_mouse_entered():
	hovered.emit(self)

func _on_mouse_exited():
	unhovered.emit(self)
