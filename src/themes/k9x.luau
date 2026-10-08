--!strict

-- k9x v1 - librería privada en español
-- Basada en Rayfield Gen2 (c) 2026 Corridon Capital, MPL-2.0 (https://github.com/SiriusSoftwareLtd/rayfield-gen2)
-- Base: k9x (c) 2026 Corridon Capital, MPL-2.0
-- Cambios k9x: acento violeta, fondo mas frio, defaults propios.
-- Licencia base se mantiene: https://mozilla.org/MPL/2.0/.

return {
	WindowColor = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(9, 9, 14)),
		ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(18, 16, 28)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 24, 44)),
	}),
	ShadowColor = Color3.fromRGB(8, 6, 16),

	ElementStroke = Color3.fromRGB(42, 38, 62),
	ElementGradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 22, 38)),
		ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(30, 27, 48)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 27, 48)),
	}),
	ElementStrokeGradient = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(62, 56, 96)),
		ColorSequenceKeypoint.new(0.9999, Color3.fromRGB(78, 70, 120)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(62, 56, 96)),
	}),
	ElementStrokeHover = Color3.fromRGB(88, 76, 140),

	TabBackground = ColorSequence.new(Color3.fromRGB(48, 42, 78), Color3.fromRGB(28, 26, 46)),
	TabStroke = ColorSequence.new(Color3.fromRGB(98, 84, 160), Color3.fromRGB(48, 42, 78)),

	SliderBackground = Color3.fromRGB(36, 33, 58),
	SliderBackgroundHover = Color3.fromRGB(48, 44, 76),
	SliderProgress = ColorSequence.new(Color3.fromRGB(124, 58, 237), Color3.fromRGB(99, 40, 200)),

	-- Acento k9x violeta
	AccentColor = Color3.fromRGB(124, 58, 237),
	AccentStroke = Color3.fromRGB(167, 139, 250),

	ToggleKnobOff = Color3.fromRGB(220, 214, 240),

	StatBackground = Color3.fromRGB(18, 16, 28),

	DropdownHighlight = Color3.fromRGB(124, 58, 237),

	NeutralButton = Color3.fromRGB(36, 33, 58),
	NeutralButtonHover = Color3.fromRGB(52, 48, 84),
	NeutralButtonStroke = Color3.fromRGB(140, 120, 220),
}
