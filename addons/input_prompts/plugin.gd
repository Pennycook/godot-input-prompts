# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends EditorPlugin

var inspector_plugin = preload("res://addons/input_prompts/inspector_plugin.gd").new()


func _enter_tree():
	add_autoload_singleton("PromptManager", "res://addons/input_prompts/input_prompt_manager.gd")
	add_inspector_plugin(inspector_plugin)

	if Engine.is_editor_hint():
		var deadzone_setting := "addons/input_prompts/joypad_detection_deadzone"
		if not ProjectSettings.has_setting(deadzone_setting):
			ProjectSettings.set_setting(deadzone_setting, 0.5)
			ProjectSettings.set_initial_value(deadzone_setting, 0.5)
			ProjectSettings.set_as_basic(deadzone_setting, true)
			var property_info = {
				"name": deadzone_setting,
				"type": TYPE_FLOAT,
				"hint": PROPERTY_HINT_RANGE,
				"hint_string": "0,1"
			}
		ProjectSettings.save()


func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	remove_autoload_singleton("PromptManager")
