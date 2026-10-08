-- k9x loader (executor). Usa request(), no HttpGet.
-- Compila: wax bundle output="k9x.lua" (wax.project.json), súbelo a main, luego:

local URL = "https://raw.githubusercontent.com/wNyxBaby/Fxr/main/k9x.lua"

local k9x = loadstring(request({ Url = URL, Method = "GET" }).Body)()

-- Plantilla mínima en español. Añade tus pestañas y elementos aquí.
local window = k9x:CreateWindow({
    name = "k9x",
    showName = "k9x",
    sidebarLayout = true,
    translations = { es = { ["Home"] = "Inicio", ["Gameplay"] = "Juego" } },
})
window:SetLocale("es")

local tab = window:CreateTab({ name = "Inicio" })
tab:CreateSection({ name = "Juego" })
-- tab:CreateToggle({ name = "Sprint automático", callback = function(v) print(v) end })

window:Navigate("Inicio")
return window
