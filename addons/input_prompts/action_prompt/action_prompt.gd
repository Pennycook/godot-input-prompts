# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/action_prompt/icon.svg")
class_name ActionPrompt
extends "res://addons/input_prompts/input_prompt.gd"
## Displays a prompt based on an action registered in the [InputMap].
##
## Displays a prompt based on an action registered in the [InputMap].
## The texture used for the prompt is determined automatically, based on the
## contents of the [InputMap] and an icon preference. When the icon preference
## is set to "Automatic", the prompt automatically adjusts to match the most
## recent input device.


## The name of an action registered in the [InputMap].
var action := "ui_accept":
	set = _set_action

## The icon preference for this prompt:
## Automatic (0), Xbox (1), Sony (2), Nintendo (3), Keyboard (4).
## When set to "Automatic", the prompt automatically adjusts to match the most
## recent input device.
var icon: int = Icons.AUTOMATIC:
	set = _set_icon


func _ready():
	_update_icon()


func _set_action(new_action: String):
	action = new_action
	_update_icon()


func _set_icon(new_icon):
	icon = new_icon
	_update_icon()


func _find_event(list: Array, types: Array):
	for candidate in list:
		for type in types:
			if is_instance_of(candidate, type):
				return candidate
	return null


func _update_icon():
	# In the Editor, InputMap reflects Editor settings
	# Read the list of actions from ProjectSettings instead
	var events: Array = []
	if Engine.is_editor_hint():
		events = ProjectSettings.get_setting("input/" + action)["events"]
	else:
		events = InputMap.action_get_events(action)

	# If icon is set to AUTOMATIC, first determine which icon to display
	var display_icon: int = icon
	if icon == Icons.AUTOMATIC:
		display_icon = PromptManager.icons

	# Choose the atlas and region associated with the InputEvent
	# If the InputMap contains multiple events, choose the first
	if display_icon == Icons.KEYBOARD:
		var types = [InputEventKey, InputEventMouseButton]
		var ev = _find_event(events, types)
		if not (ev is InputEventKey or ev is InputEventMouseButton):
			push_error("No Key/Mouse input for " + action + " in InputMap")
		if ev is InputEventKey:
			var scancode = ev.get_keycode()
			var textures := PromptManager.get_keyboard_textures()
			texture = textures.get_texture(scancode)
		elif ev is InputEventMouseButton:
			var button = ev.get_button_index()
			var textures := PromptManager.get_mouse_textures()
			texture = textures.get_texture(button)
	else:
		var types = [InputEventJoypadButton, InputEventJoypadMotion]
		var ev = _find_event(events, types)
		if not (ev is InputEventJoypadButton or ev is InputEventJoypadMotion):
			push_error("No Joypad input for " + action + " in InputMap")
		if ev is InputEventJoypadButton:
			var button = ev.get_button_index()
			var textures := PromptManager.get_joypad_button_textures(display_icon)
			texture = textures.get_texture(button)
		elif ev is InputEventJoypadMotion:
			var axis = ev.get_axis()
			var value = ev.get_axis_value()
			var textures := PromptManager.get_joypad_motion_textures(display_icon)
			texture = textures.get_texture(axis, value)
	queue_redraw()


func _input(event: InputEvent):
	if not event.is_action_pressed(action):
		return
	emit_signal("pressed")


func _get_property_list():
	var properties = []
	properties.append(
		{
			name = "ActionPrompt",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		}
	)
	# In the Editor, InputMap reflects Editor settings
	# Read the list of actions from ProjectSettings instead
	var actions: String = ""
	for property in ProjectSettings.get_property_list():
		var name = property["name"]
		if name.begins_with("input/"):
			if actions != "":
				actions += ","
			actions += name.trim_prefix("input/")
	properties.append(
		{name = "action", type = TYPE_STRING, hint = PROPERTY_HINT_ENUM, hint_string = actions}
	)
	properties.append(
		{
			name = "icon",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "Automatic,Xbox,Sony,Nintendo,Keyboard"
		}
	)
	return properties


func _get_configuration_warnings():
	return []
