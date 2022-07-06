# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends "res://addons/input_prompts/BasePrompt.gd"

var action = "ui_accept" setget _set_action
var icon = InputPrompts.Icons.AUTOMATIC setget _set_icon
var _events : Array = []

func _ready():
	self.action = action
	self.icon = icon
	_update_icon()

func _set_action(new_action : String):
	action = new_action
	# In the Editor, InputMap reflects Editor settings
	# Read the list of actions from ProjectSettings instead
	if Engine.editor_hint:
		_events = ProjectSettings.get_setting("input/" + action)["events"]
	else:
		_events = InputMap.get_action_list(action)
	_update_icon()

func _set_icon(new_icon):
	icon = new_icon
	_update_icon()

func _find_event(list : Array, types : Array):
	for candidate in list:
		for type in types:
			if candidate is type:
				return candidate
	return null

func _update_icon():
	# If icon is set to AUTOMATIC, first determine which icon to display
	var display_icon : int = icon
	if icon == InputPrompts.Icons.AUTOMATIC:
		display_icon = InputPrompts.get_icons()

	# Choose the atlas and region associated with the InputEvent
	# If the InputMap contains multiple events, choose the first
	if display_icon == InputPrompts.Icons.KEYBOARD:
		var types = [InputEventKey, InputEventMouseButton]
		var ev = _find_event(_events, types)
		if not (ev is InputEventKey or ev is InputEventMouseButton):
			push_error("No Key/Mouse input for " + action + " in InputMap")
		if ev is InputEventKey:
			var scancode = ev.get_scancode()
			texture.atlas = InputPrompts.get_key_atlas()
			texture.region = InputPrompts.get_key_region(scancode)
		elif ev is InputEventMouseButton:
			var button = ev.get_button_index()
			texture.atlas = InputPrompts.get_mouse_atlas()
			texture.region = InputPrompts.get_mouse_region(button)
	else:
		var types = [InputEventJoypadButton, InputEventJoypadMotion]
		var ev = _find_event(_events, types)
		if not (ev is InputEventJoypadButton or ev is InputEventJoypadMotion):
			push_error("No Joypad input for " + action + " in InputMap")
		if ev is InputEventJoypadButton:
			var button = ev.get_button_index()
			texture.atlas = InputPrompts.get_joypad_button_atlas(display_icon)
			texture.region = InputPrompts.get_joypad_button_region(button)
		elif ev is InputEventJoypadMotion:
			var axis = ev.get_axis()
			var value = ev.get_axis_value()
			texture.atlas = InputPrompts.get_joypad_motion_atlas()
			texture.region = InputPrompts.get_joypad_motion_region(axis, value)
	update()

func _input(event : InputEvent):
	if not event.is_action_pressed(action):
		return
	emit_signal("pressed")

func _get_property_list():
	var properties = []
	properties.append({
		name = "ActionPrompt",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	# In the Editor, InputMap reflects Editor settings
	# Read the list of actions from ProjectSettings instead
	var actions : String = ""
	for property in ProjectSettings.get_property_list():
		var name = property["name"]
		if name.begins_with("input/"):
			if actions != "":
				actions += ","
			actions += name.trim_prefix("input/")
	properties.append({
		name = "action",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = actions
	})
	properties.append({
		name = "icon",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Automatic,Xbox,Sony,Nintendo,Keyboard"
	})
	return properties
