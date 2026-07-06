-- loader.lua
local owner = "burgueralt07-crypto"
local repo = "realistapapada"
local branch = "main"
local baseUrl = "https://raw.githubusercontent.com/" .. owner .. "/" .. repo .. "/" .. branch .. "/"

-- Função de Download Inteligente
local function downloadFile(path)
    -- Se o arquivo já existe, não baixa de novo
    if isfile(path) then return true end
    
    local url = baseUrl .. path
    local success, content = pcall(function() return game:HttpGet(url) end)
    
    if success and content ~= "404: Not Found" and content ~= "" then
        -- Garante que a pasta pai exista antes de escrever
        local folder = path:match("(.+)/")
        if folder and not isfolder(folder) then makefolder(folder) end
        
        writefile(path, content)
        print("[RealistaPapada] Baixado sob demanda: " .. path)
        return true
    else
        warn("[RealistaPapada] Falha ao baixar: " .. path)
        return false
    end
end

-- Hook para interceptar o 'readfile' original do Vape
local oldReadfile = readfile
getgenv().readfile = function(path)
    downloadFile(path) -- Tenta baixar se não existir
    return oldReadfile(path)
end

-- Iniciar carregamento
if downloadFile("newvape/main.lua") then
    loadstring(readfile("newvape/main.lua"))()
else
    error("Erro crítico: Não foi possível baixar o main.lua do seu repositório.")
end
