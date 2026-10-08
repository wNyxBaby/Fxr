--!strict
-- k9x - ejemplo base (fork Rayfield Gen2, MPL-2.0)
-- Uso en Studio: pon src como ModuleScript "k9x" en ReplicatedStorage

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local k9x = require(ReplicatedStorage:WaitForChild("k9x"))

local window = k9x:CreateWindow({
	name = "k9x",
	showName = "k9x",
	sidebarLayout = true, -- true = pestañas a la izquierda, false = arriba
	translations = {
		es = {
			["Home"] = "Inicio",
			["Gameplay"] = "Juego",
			["Interface"] = "Interfaz",
			["Auto Sprint"] = "Sprint automático",
			["Field of View"] = "Campo de visión",
			["Search"] = "Buscar",
			["Settings"] = "Ajustes",
		},
	},
	-- el tema ya es "k9x" por defecto
	configuration = {
		autoSave = true, -- guarda solo
		autoLoad = true, -- carga al abrir
		fileName = "k9xConfig",
	},
})
window:SetLocale("es")

window:CreateSection({ name = "General" })

local inicio = window:CreateTab({ name = "Inicio" })
inicio:CreateSection({ name = "Juego" })

inicio:CreateToggle({
	name = "Sprint automático",
	value = true,
	callback = function(v) print("Sprint:", v) end,
})

inicio:CreateSlider({
	name = "Campo de visión",
	range = { 70, 120 },
	increment = 1,
	value = 90,
	suffix = "°",
	callback = function(v) workspace.CurrentCamera.FieldOfView = v end,
})

inicio:CreateButton({
	name = "Reiniciar personaje",
	callback = function() game.Players.LocalPlayer.Character:BreakJoints() end,
})

window:Navigate("Inicio")
return window
