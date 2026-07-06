-- Configuração do Repositório
local owner = "burgueralt07-crypto"
local repo = "realistapapada"
local branch = "main"
local baseUrl = "https://raw.githubusercontent.com/" .. owner .. "/" .. repo .. "/" .. branch .. "/"

-- Lista de pastas e arquivos essenciais
local folders = {"newvape", "newvape/games", "newvape/profiles", "newvape/assets", "newvape/libraries", "newvape/guis"}
local essentialFiles = {"newvape/main.lua"} -- Adicione outros aqui se necessário

-- Função de Download
local function downloadFile(path)
    local url = baseUrl .. path
    local suc, res = pcall(function() return game:HttpGet(url) end)
    if suc and res ~= "404: Not Found" and res ~= "" then
        writefile(path, res)
        return true
    else
        warn("Erro ao baixar: " .. path)
        return false
    end
end

-- Inicialização da Estrutura
for _, folder in pairs(folders) do
    if not isfolder(folder) then
        makefolder(folder)
    end
end

-- Garantir que os arquivos essenciais existam
for _, file in pairs(essentialFiles) do
    if not isfile(file) then
        print("[RealistaPapada] Baixando: " .. file)
        downloadFile(file)
    end
end

-- Carregamento Final
if isfile("newvape/main.lua") then
    print("[RealistaPapada] Iniciando...")
    loadstring(readfile("newvape/main.lua"))()
else
    error("Erro crítico: newvape/main.lua não foi encontrado.")
end
