# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends EditorPlugin

var inspector_plugin = preload("res://addons/input_prompts/inspector_plugin.gd").new()

func _enter_tree():
	add_autoload_singleton("InputPrompts", "res://addons/input_prompts/input_prompts.gd")
	add_custom_type("ActionPrompt", "TextureRect", load("res://addons/input_prompts/action_prompt/action_prompt.gd"), preload("res://addons/input_prompts/action_prompt/icon.png"))
	add_custom_type("JoypadButtonPrompt", "TextureRect", load("res://addons/input_prompts/joypad_button_prompt/joypad_button_prompt.gd"), preload("res://addons/input_prompts/joypad_button_prompt/icon.png"))
	add_custom_type("JoypadMotionPrompt", "TextureRect", load("res://addons/input_prompts/joypad_motion_prompt/joypad_motion_prompt.gd"), preload("res://addons/input_prompts/joypad_motion_prompt/icon.png"))
	add_custom_type("KeyPrompt", "TextureRect", load("res://addons/input_prompts/key_prompt/key_prompt.gd"), preload("res://addons/input_prompts/key_prompt/icon.png"))
	add_custom_type("MouseButtonPrompt", "TextureRect", load("res://addons/input_prompts/mouse_button_prompt/mouse_button_prompt.gd"), preload("res://addons/input_prompts/mouse_button_prompt/icon.png"))
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	remove_custom_type("MouseButtonPrompt")
	remove_custom_type("KeyPrompt")
	remove_custom_type("JoypadMotionPrompt")
	remove_custom_type("JoypadButtonPrompt")
	remove_custom_type("ActionPrompt")
	remove_autoload_singleton("InputPrompts")
