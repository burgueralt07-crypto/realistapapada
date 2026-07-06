-- loader.lua (Hack de bypass)

-- 1. Cria uma função de leitura que não quebra se o arquivo não existir
local oldReadfile = readfile
getgenv().readfile = function(path)
    if not isfile(path) then
        warn("Arquivo não encontrado, mas ignorando erro para evitar crash: " .. path)
        return "" -- Retorna vazio em vez de dar erro, permitindo que o script siga
    end
    return oldReadfile(path)
end

-- 2. Carrega o seu main.lua local (que você já tem na pasta)
if isfile("newvape/main.lua") then
    print("[RealistaPapada] Iniciando a partir do disco local...")
    loadstring(readfile("newvape/main.lua"))()
else
    -- Se nem o main.lua existir, aí sim tentamos baixar da web
    local url = "https://raw.githubusercontent.com/burgueralt07-crypto/realistapapada/main/newvape/main.lua"
    local suc, res = pcall(function() return game:HttpGet(url) end)
    if suc and res ~= "404: Not Found" then
        writefile("newvape/main.lua", res)
        loadstring(res)()
    else
        error("Erro fatal: O arquivo newvape/main.lua não existe nem localmente nem no GitHub.")
    end
end
