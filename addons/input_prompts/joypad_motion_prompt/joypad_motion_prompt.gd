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

## A joypad axis, such as [constant @GlobalScope. JOY_AXIS_LEFT_X].
var axis := 0:
	set = _set_axis

## The value of the axis, either -1.0 (minus) or 1.0 (plus).
var axis_value := 1.0:
	set = _set_axis_value

## The icon preference for this prompt:
## Automatic (0), Xbox (1), Sony (2), Nintendo (3), Generic (4), Steam Deck (5).
## When set to "Automatic", the prompt automatically adjusts to match the most
## recent joypad device.
var icon: int = Icons.AUTOMATIC: 
	set = _set_icon


func _ready():
	_update_icon()


func _set_axis(new_axis: int):
	axis = new_axis
	_update_event()
	_update_icon()


func _set_axis_value(new_axis_value: float):
	axis_value = new_axis_value
	_update_event()
	_update_icon()


func _set_icon(new_icon):
	icon = new_icon
	_update_icon()


func _update_event():
	var event := InputEventJoypadMotion.new()
	event.axis = axis
	event.axis_value = axis_value
	events = [event]


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
	properties.append(
		{name = "axis", type = TYPE_INT, hint = PROPERTY_HINT_RANGE, hint_string = "0,5"}
	)
	properties.append(
		{
			name = "axis_value",
			type = TYPE_FLOAT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "-1.0,-1.0,1.0,1.0"
		}
	)
	properties.append(
		{
			name = "icon",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "Automatic,Xbox,Sony,Nintendo,Generic,Steam Deck"
		}
	)
	return properties
