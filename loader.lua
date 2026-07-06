-- loader.lua
local function getUrl(path)
    return "https://raw.githubusercontent.com/burgueralt07-crypto/realistapapada/main/" .. path
end

-- Baixa o main e executa
local mainScript = game:HttpGet(getUrl("newvape/main.lua"))
loadstring(mainScript)()
