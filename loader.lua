-- loader.lua (Versão Final de Força Bruta)
local owner = "burgueralt07-crypto"
local repo = "realistapapada"

-- Função para baixar arquivos críticos
local function forceDownload(path)
    local url = "https://raw.githubusercontent.com/"..owner.."/"..repo.."/main/"..path
    local suc, res = pcall(function() return game:HttpGet(url) end)
    if suc and res ~= "404: Not Found" then
        if path:find("/") then
            local dir = path:match("(.*)/")
            if not isfolder(dir) then makefolder(dir) end
        end
        writefile(path, res)
    end
end

-- Lista de pastas do Vape
local folders = {"newvape", "newvape/games", "newvape/profiles", "newvape/assets", "newvape/libraries", "newvape/guis"}
for _, f in pairs(folders) do if not isfolder(f) then makefolder(f) end end

-- Lista de arquivos que você sabe que existem no seu GitHub
-- Se você subiu a pasta newvape, você precisa garantir que o loader baixe o main
forceDownload("newvape/main.lua")

-- Se o main.lua rodar, ele vai tentar carregar o resto. 
-- SE ELE DER ERRO EM OUTRO ARQUIVO, VOCÊ TEM QUE ADICIONAR O FORCE DOWNLOAD DESSE ARQUIVO AQUI EM CIMA.
loadstring(readfile("newvape/main.lua"))()
