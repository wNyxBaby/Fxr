--!nonstrict

-- Copyright (c) 2026 Corridon Capital
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local Resize = {}
Resize.__index = Resize
Resize.__type = "Resize"

-- Utility
local utility = script.Parent.Parent.utility

-- Variables
local variables = require(utility.variables)
local windowSizing = require(utility.windowSizing)

-- Agarre curvo dentro de la esquina inferior derecha para cambiar el tamaño.
-- Vive dentro del marco (nada sobresale) y respeta los mínimos del perfil.
function Resize.new(window)
    local self = setmetatable({
        window = assert(window, "Missing argument #1 (Window expected)"),
    }, Resize)

    -- base redondeada del agarre
    self.grip = self.window:Create("Frame", {
        Name = "ResizeGrip",
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -10, 1, -10),
        Size = UDim2.fromOffset(26, 26),
        BackgroundTransparency = 1,
        ZIndex = 50,
        Parent = self.window.main,
    })

    -- tres líneas diagonales (⋰)
    local function bar(len, dx, dy)
        return self.window:Create("Frame", {
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -dx, 1, -dy),
            Size = UDim2.fromOffset(len, 2),
            Rotation = -45,
            BorderSizePixel = 0,
            BackgroundTransparency = 0.45,
            ZIndex = 51,
            Parent = self.grip,
        }, { BackgroundColor3 = "ContentColor" })
    end

    self.bars = { bar(16, 4, 4), bar(11, 4, 9), bar(6, 4, 14) }

    self.gripInteract = self.window:Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        TextTransparency = 1,
        ZIndex = 52,
        Parent = self.grip,
    })

    local resizing = false
    local startMouse = Vector2.zero
    local startSize = Vector2.zero

    local function limits()
        local profile = windowSizing.profile(self.window.layout.mode)
        local min = profile.minSize
        local max = Vector2.new(profile.defaultSize.X, profile.defaultSize.Y)
        local camera = workspace.CurrentCamera
        if camera then
            local view = camera.ViewportSize
            local fit = windowSizing.fit(view, self.window.layout.mode)
            max = Vector2.new(
                math.max(fit.X.Offset, self.window.size.X.Offset),
                math.max(fit.Y.Offset, self.window.size.Y.Offset)
            )
            max = Vector2.new(math.min(max.X, view.X - 48), math.min(max.Y, view.Y - 48))
            max = Vector2.new(math.max(max.X, min.X), math.max(max.Y, min.Y))
        end
        return min, max
    end

    local function setLit(lit)
        for _, line in self.bars do
            variables.tweenService
                :Create(
                    line,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                    { BackgroundTransparency = if lit then 0 else 0.45 }
                )
                :Play()
        end
    end

    self.window:Connect(self.gripInteract.MouseEnter, function()
        if not resizing then
            setLit(true)
        end
    end)

    self.window:Connect(self.gripInteract.MouseLeave, function()
        if not resizing then
            setLit(false)
        end
    end)

    self.window:Connect(self.gripInteract.InputBegan, function(input, processed)
        if processed then
            return
        end
        local inputType = input.UserInputType.Name
        if inputType == "MouseButton1" or inputType == "Touch" then
            if not self.window:_interactive() then
                return
            end
            resizing = true
            setLit(true)
            startMouse = variables.userInputService:GetMouseLocation()
            startSize = Vector2.new(self.window.size.X.Offset, self.window.size.Y.Offset)
        end
    end)

    local function releaseResize()
        if not resizing then
            return
        end
        resizing = false
        setLit(false)
    end

    self.window:Connect(variables.userInputService.InputEnded, function(input)
        local inputType = input.UserInputType.Name
        if inputType == "MouseButton1" or inputType == "Touch" then
            releaseResize()
        end
    end)

    self.window:Connect(variables.userInputService.WindowFocusReleased, releaseResize)

    self.window:Connect(variables.runService.RenderStepped, function()
        if not resizing then
            return
        end
        if not self.window:_interactive() then
            releaseResize()
            return
        end
        local min, max = limits()
        local mouse = variables.userInputService:GetMouseLocation()
        local delta = mouse - startMouse
        local nx = math.clamp(startSize.X + delta.X, min.X, max.X)
        local ny = math.clamp(startSize.Y + delta.Y, min.Y, max.Y)
        nx, ny = math.floor(nx), math.floor(ny)
        local size = UDim2.fromOffset(nx, ny)
        if size ~= self.window.size then
            self.window.size = size
            self.window.main.Size = size
            self.window:_applyRailWidth()
            self.window:_clampToScreen()
        end
    end)

    return self
end

return Resize
