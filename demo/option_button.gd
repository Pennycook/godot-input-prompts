# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
extends OptionButton


func _on_item_selected(index: int) -> void:
	PromptManager.preferred_icons = index as InputPrompt.Icons
