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
			ProjectSettings.add_property_info(
				{
					"name": deadzone_setting,
					"type": TYPE_FLOAT,
					"hint": PROPERTY_HINT_RANGE,
					"hint_string": "0,1"
				}
			)

		var icon_settings = {
			"addons/input_prompts/icons/keyboard":
			"res://addons/input_prompts/key_prompt/keys.tres",
			"addons/input_prompts/icons/mouse_buttons":
			"res://addons/input_prompts/mouse_button_prompt/buttons.tres",
			"addons/input_prompts/icons/joypad_buttons/nintendo":
			"res://addons/input_prompts/joypad_button_prompt/nintendo.tres",
			"addons/input_prompts/icons/joypad_buttons/sony":
			"res://addons/input_prompts/joypad_button_prompt/sony.tres",
			"addons/input_prompts/icons/joypad_buttons/xbox":
			"res://addons/input_prompts/joypad_button_prompt/xbox.tres",
			"addons/input_prompts/icons/joypad_motion/nintendo":
			"res://addons/input_prompts/joypad_motion_prompt/nintendo.tres",
			"addons/input_prompts/icons/joypad_motion/sony":
			"res://addons/input_prompts/joypad_motion_prompt/sony.tres",
			"addons/input_prompts/icons/joypad_motion/xbox":
			"res://addons/input_prompts/joypad_motion_prompt/xbox.tres",
		}
		for setting in icon_settings.keys():
			var value = icon_settings[setting]
			if not ProjectSettings.has_setting(setting):
				ProjectSettings.set_setting(setting, value)
				ProjectSettings.set_initial_value(setting, value)
				ProjectSettings.add_property_info(
					{
						"name": setting,
						"type": TYPE_STRING,
						"hint": PROPERTY_HINT_FILE,
						"hint_string": "*.tres,*.res"
					}
				)

		ProjectSettings.save()


func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	remove_autoload_singleton("PromptManager")
