-- Anticheat simples para verificar se o jogador está usando hacks
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Função para verificar a velocidade do jogador
local function checkSpeed(player)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local humanoid = character:FindFirstChild("Humanoid")
    local previousPosition = character.HumanoidRootPart.Position
    local currentPosition
    local maxSpeed = 50  -- Limite de velocidade permitido

    -- Verifica a velocidade a cada segundo
    while player.Parent do
        wait(1)
        currentPosition = character.HumanoidRootPart.Position
        local distanceTravelled = (currentPosition - previousPosition).Magnitude
        if distanceTravelled > maxSpeed then
            print(player.Name .. " está se movendo muito rápido!")
            -- Ação para punir o jogador, como desconectar
            player:Kick("Você foi desconectado por usar velocidade excessiva.")
        end
        previousPosition = currentPosition
    end
end

-- Conectar a função de verificação ao entrar no jogo
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        checkSpeed(player)
    end)
end)
