# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends EditorInspectorPlugin

func can_handle(object):
	return object.has_method("_is_input_prompt")

func parse_property(object, type, path, hint, hint_text, usage):
	# Hide the texture property of TextureRect to ensure that user can only
	# modify it indirectly (e.g. via setting key, button, action or icon)
	return path == "texture"
