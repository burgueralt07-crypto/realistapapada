-- loader.lua
local function download(path)
    local url = "https://raw.githubusercontent.com/burgueralt07-crypto/realistapapada/main/" .. path
    local suc, res = pcall(function() return game:HttpGet(url) end)
    if suc then return res else error("Falha ao baixar: " .. path) end
end

-- Salva e executa o main do Vape
writefile("newvape/main.lua", download("newvape/main.lua"))
loadstring(readfile("newvape/main.lua"))()