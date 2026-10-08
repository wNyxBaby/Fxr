# k9x

Librería de interfaz privada en español para Roblox.

Basada en Rayfield Gen2 (c) 2026 Corridon Capital, MPL-2.0 —
https://github.com/SiriusSoftwareLtd/rayfield-gen2

## Uso

```lua
local k9x = loadstring(request({ Url = "https://raw.githubusercontent.com/wNyxBaby/Fxr/main/k9x.lua", Method = "GET" }).Body)()

local window = k9x:CreateWindow({ name = "k9x", showName = "k9x", sidebarLayout = true })
window:SetLocale("es")

local tab = window:CreateTab({ name = "Inicio" })
window:Navigate("Inicio")
return window
```

Ver `example.k9x.client.luau` para el ejemplo completo en español.

## Licencia

Mozilla Public License 2.0. Ver [LICENSE](LICENSE).
