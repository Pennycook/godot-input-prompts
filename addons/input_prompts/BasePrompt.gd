# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends TextureRect

signal pressed()

func _is_input_prompt():
	return true

func _ready():
	self.texture = AtlasTexture.new()

func _update_icon():
	pass

func _enter_tree():
	InputPrompts.connect("icons_changed", self, "_update_icon")

func _exit_tree():
	InputPrompts.disconnect("icons_changed", self, "_update_icon")
