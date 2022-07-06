# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends "res://addons/input_prompts/BasePrompt.gd"

var axis = 0 setget _set_axis
var axis_value = -1 setget _set_axis_value

func _ready():
	self.axis = axis
	self.axis_value = axis_value
	_update_icon()

func _set_axis(new_axis : int):
	axis = new_axis
	_update_icon()

func _set_axis_value(new_value : int):
	axis_value = new_value
	_update_icon()

func _update_icon():
	texture.atlas = InputPrompts.get_joypad_motion_atlas()
	texture.region = InputPrompts.get_joypad_motion_region(axis, axis_value)
	update()

func _input(event : InputEvent):
	if not event is InputEventJoypadMotion:
		return
	if not event.get_axis() == axis:
		return
	if axis_value == -1 and event.get_axis_value() > 0:
		return
	if axis_value == 1 and event.get_axis_value() < 0:
		return
	emit_signal("pressed")

func _get_property_list():
	var properties = []
	properties.append({
		name = "JoypadMotionPrompt",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	properties.append({
		name = "axis",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Left Horizontal:0,Left Vertical:1,Right Horizontal:2,Right Vertical:3"
	})
	properties.append({
		name = "axis_value",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Negative:-1,Positive:1"
	})
	return properties
