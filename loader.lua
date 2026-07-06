-- loader.lua
local owner = "burgueralt07-crypto"
local repo = "realistapapada"
local baseUrl = "https://raw.githubusercontent.com/"..owner.."/"..repo.."/main/"

-- 1. Cria a estrutura de pastas necessária
local folders = {"newvape", "newvape/games", "newvape/profiles", "newvape/assets", "newvape/libraries", "newvape/guis"}
for _, f in pairs(folders) do if not isfolder(f) then makefolder(f) end end

-- 2. "Sequestra" a função de download do Vape antes dele rodar
getgenv().downloadFile = function(path, func)
    if not isfile(path) then
        local url = baseUrl .. path
        local suc, res = pcall(function() return game:HttpGet(url) end)
        if suc and res ~= "404: Not Found" and #res > 0 then
            writefile(path, res)
        else
            warn("Falha ao baixar: " .. path)
            return nil
        end
    end
    return (func or readfile)(path)
end

-- 3. Baixa o main manualmente para garantir
local mainUrl = baseUrl .. "newvape/main.lua"
local suc, res = pcall(function() return game:HttpGet(mainUrl) end)

if suc then
    writefile("newvape/main.lua", res)
    -- 4. Carrega o script
    loadstring(res)()
else
    error("Não consegui nem baixar o main.lua. Verifique se o arquivo existe no GitHub!")
end
