# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends EditorPlugin

var inspector_plugin = preload("res://addons/input_prompts/InspectorPlugin.gd").new()

func _enter_tree():
	add_autoload_singleton("InputPrompts", "res://addons/input_prompts/InputPrompts.gd")
	add_custom_type("ActionPrompt", "TextureRect", load("res://addons/input_prompts/ActionPrompt/ActionPrompt.gd"), preload("res://addons/input_prompts/ActionPrompt/icon.png"))
	add_custom_type("JoypadButtonPrompt", "TextureRect", load("res://addons/input_prompts/JoypadButtonPrompt/JoypadButtonPrompt.gd"), preload("res://addons/input_prompts/JoypadButtonPrompt/icon.png"))
	add_custom_type("JoypadMotionPrompt", "TextureRect", load("res://addons/input_prompts/JoypadMotionPrompt/JoypadMotionPrompt.gd"), preload("res://addons/input_prompts/JoypadMotionPrompt/icon.png"))
	add_custom_type("KeyPrompt", "TextureRect", load("res://addons/input_prompts/KeyPrompt/KeyPrompt.gd"), preload("res://addons/input_prompts/KeyPrompt/icon.png"))
	add_custom_type("MouseButtonPrompt", "TextureRect", load("res://addons/input_prompts/MouseButtonPrompt/MouseButtonPrompt.gd"), preload("res://addons/input_prompts/MouseButtonPrompt/icon.png"))
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	remove_custom_type("MouseButtonPrompt")
	remove_custom_type("KeyPrompt")
	remove_custom_type("JoypadMotionPrompt")
	remove_custom_type("JoypadButtonPrompt")
	remove_custom_type("ActionPrompt")
	remove_autoload_singleton("InputPrompts")
