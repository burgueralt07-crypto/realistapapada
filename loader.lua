-- loader.lua
local owner = "burgueralt07-crypto"
local repo = "realistapapada"
local baseUrl = "https://raw.githubusercontent.com/"..owner.."/"..repo.."/main/"

local function downloadFile(path)
    -- Se o arquivo já existe no PC, não faz nada
    if isfile(path) then return end
    
    local url = baseUrl .. path
    local suc, res = pcall(function() return game:HttpGet(url) end)
    
    -- Se o download funcionou e não deu 404, salva o arquivo
    if suc and res ~= "404: Not Found" and res ~= "400: Invalid request" and #res > 0 then
        -- Cria a pasta se necessário
        local dir = path:match("(.*)/")
        if dir and not isfolder(dir) then makefolder(dir) end
        writefile(path, res)
        print("[RealistaPapada] Baixado: " .. path)
    else
        -- AQUI ESTÁ O SEGREDO: Em vez de dar 'error()', damos um 'warn'
        -- Isso faz o Vape continuar tentando carregar em vez de travar tudo.
        warn("[RealistaPapada] Arquivo ignorado ou não encontrado: " .. path)
    end
end

-- Tenta baixar o essencial
downloadFile("newvape/main.lua")

-- Se o main.lua não existir, ele vai parar aqui, mas não vai travar com erro de 'downloadFile'
if isfile("newvape/main.lua") then
    loadstring(readfile("newvape/main.lua"))()
else
    warn("Erro: newvape/main.lua não encontrado!")
end
