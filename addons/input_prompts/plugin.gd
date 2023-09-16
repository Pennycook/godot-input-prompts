# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends EditorPlugin

var inspector_plugin = preload("res://addons/input_prompts/inspector_plugin.gd").new()


func _enter_tree():
	add_autoload_singleton("InputPrompts", "res://addons/input_prompts/input_prompts.gd")
	add_inspector_plugin(inspector_plugin)


func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	remove_autoload_singleton("InputPrompts")
