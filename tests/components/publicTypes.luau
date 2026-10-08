--!strict

-- Copyright (c) 2026 Corridon Capital
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Typecheck only. The runner collects *.spec.luau, so this is never required and never runs -
-- it exists so luau-lsp checks the public handles against what the elements actually ship. A
-- method that exists at runtime but never made it into types.luau fails here.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local k9x = require(ReplicatedStorage.k9x)

return function(window: k9x.Window, tab: k9x.Tab)
    -- a heading in the sidebar rail, not in a tab's element list
    local railSection: k9x.TabSection = window:CreateSection({ name = "General" })
    railSection:Remove()

    local progress: k9x.Progress = tab:CreateProgress({ name = "Progress" })
    progress:Set(0.5)
    local progressValue: number = progress:Get()
    local progressRatio: number = progress:GetPercentage()
    progress:SetRange(0, 10)
    progress:SetText("halfway")
    progress:SetText(nil) -- back to the formatter
    progress:SetIndeterminate(true)
    progress:Remove()

    local console: k9x.Console = tab:CreateConsole({ name = "Console" })
    console:Set("body")
    console:Append("line")
    console:Clear()
    local consoleBody: string = console:Get()
    local copied: boolean = console:Copy()
    console:SetHeight(160)
    console:Remove()

    -- every element you can operate takes a lock, and only those
    local button: k9x.Button = tab:CreateButton({ name = "Button" })
    local toggle: k9x.Toggle = tab:CreateToggle({ name = "Toggle" })
    local slider: k9x.Slider = tab:CreateSlider({ name = "Slider" })
    local dropdown: k9x.Dropdown = tab:CreateDropdown({ name = "Dropdown" })
    local input: k9x.Input = tab:CreateInput({ name = "Input" })
    local keybind: k9x.Keybind = tab:CreateKeybind({ name = "Keybind" })
    local colorPicker: k9x.ColorPicker = tab:CreateColorPicker({ name = "Colour" })

    button:Lock("needs a key")
    toggle:Lock()
    slider:Lock()
    dropdown:Lock()
    input:Lock()
    keybind:Lock()
    colorPicker:Lock()

    button:Unlock()
    local locked: boolean = toggle:IsLocked()

    return progressValue, progressRatio, consoleBody, copied, locked
end
