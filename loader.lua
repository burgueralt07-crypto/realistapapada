-- loader.lua
local owner = "burgueralt07-crypto"
local repo = "realistapapada"
local branch = "main"
local baseUrl = "https://raw.githubusercontent.com/" .. owner .. "/" .. repo .. "/" .. branch .. "/"

-- Lista de pastas obrigatórias
local folders = {"newvape", "newvape/games", "newvape/profiles", "newvape/assets", "newvape/libraries", "newvape/guis"}

-- Função de Download Robusta
local function downloadFile(path)
    local url = baseUrl .. path
    local success, content = pcall(function() return game:HttpGet(url) end)
    
    if success and content ~= "404: Not Found" and content ~= "" then
        writefile(path, content)
        print("[RealistaPapada] Baixado com sucesso: " .. path)
    else
        warn("[RealistaPapada] Falha ao baixar: " .. path)
    end
end

-- 1. Cria as pastas
for _, folder in pairs(folders) do
    if not isfolder(folder) then makefolder(folder) end
end

-- 2. Baixa o Main e as Bibliotecas Essenciais
-- Se o erro persistir, adicione aqui outros arquivos que aparecem no erro do F9
local filesToDownload = {"newvape/main.lua", "newvape/libraries/lib.lua"} 

for _, file in pairs(filesToDownload) do
    if not isfile(file) then downloadFile(file) end
end

-- 3. Executa
if isfile("newvape/main.lua") then
    loadstring(readfile("newvape/main.lua"))()
else
    error("Erro: newvape/main.lua não encontrado após tentativa de download.")
end
