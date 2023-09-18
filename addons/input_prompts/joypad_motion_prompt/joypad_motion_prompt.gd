# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/joypad_motion_prompt/icon.svg")
class_name JoypadMotionPrompt
extends "res://addons/input_prompts/input_prompt.gd"
## Displays a prompt based on a joypad axis and value.
##
## Displays a prompt based on a joypad axis and value.
## The texture used for the prompt is determined by an icon preference. When
## the icon preference is set to "Automatic", the prompt automatically adjusts
## to match the most recent joypad device.
## [br][br]
## [b]Note[/b]: A [JoypadMotionPrompt] will never show keyboard or mouse
## prompts. To automatically reflect the most recent input device, use
## [ActionPrompt] instead.

## A joypad axis index, such as [constant @GlobalScope.JOY_AXIS_LEFT_X].
var axis := 0:
	set = _set_axis

## A joypad axis value (positive or negative).
var axis_value := -1:
	set = _set_axis_value

## The icon preference for this prompt:
## Automatic (0), Xbox (1), Sony (2), Nintendo (3).
## When set to "Automatic", the prompt automatically adjusts to match the most
## recent joypad device.
var icon: int = Icons.AUTOMATIC:
	set = _set_icon


func _ready():
	_update_icon()


func _set_axis(new_axis: int):
	axis = new_axis
	var event := InputEventJoypadMotion.new()
	event.axis = axis
	event.axis_value = axis_value
	events = [event]
	_update_icon()


func _set_axis_value(new_value: int):
	axis_value = new_value
	var event := InputEventJoypadMotion.new()
	event.axis = axis
	event.axis_value = axis_value
	events = [event]
	_update_icon()


func _set_icon(new_icon):
	icon = new_icon
	_update_icon()


func _update_icon():
	var textures := PromptManager.get_joypad_motion_textures(icon)
	texture = textures.get_texture(events[0])
	queue_redraw()


func _get_property_list():
	var properties = []
	properties.append(
		{
			name = "JoypadMotionPrompt",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		}
	)
	const AXIS_HINT := (
		"Left Horizontal:0,"
		+ "Left Vertical:1,"
		+ "Right Horizontal:2,"
		+ "Right Vertical:3,"
		+ "Left Trigger:4,"
		+ "Right Trigger:5"
	)
	properties.append(
		{name = "axis", type = TYPE_INT, hint = PROPERTY_HINT_ENUM, hint_string = AXIS_HINT}
	)
	properties.append(
		{
			name = "axis_value",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "Negative:-1,Positive:1"
		}
	)
	properties.append(
		{
			name = "icon",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "Automatic,Xbox,Sony,Nintendo"
		}
	)
	return properties
