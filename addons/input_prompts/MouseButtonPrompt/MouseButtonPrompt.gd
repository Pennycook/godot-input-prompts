# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends "res://addons/input_prompts/BasePrompt.gd"

var button = 1 setget _set_button

func _ready():
	self.button = button
	_update_icon()

func _set_button(index : int):
	button = index
	_update_icon()

func _update_icon():
	texture.atlas = InputPrompts.get_mouse_atlas()
	texture.region = InputPrompts.get_mouse_region(button)
	update()

func _input(event : InputEvent):
	if not event is InputEventMouseButton:
		return
	if not event.get_button_index() == button:
		return
	if not event.is_pressed():
		return
	emit_signal("pressed")

func _get_property_list():
	var properties = []
	properties.append({
		name = "MouseButtonPrompt",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	properties.append({
		name = "button",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Left:1,Right:2,Middle:3,Wheel Up:4,Wheel Down:5,Wheel Left:6,Wheel Right:7"
	})
	return properties
