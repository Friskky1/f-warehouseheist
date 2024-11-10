local QBCore = exports['qb-core']:GetCoreObject()
local securityGuards = {}
local pedsspawned = false

local function SpawnGuardsLab()
    local Player = PlayerPedId()
    local randomgun = Config.SecurityGuardsWeapon[math.random(1, #Config.SecurityGuardsWeapon)]

    SetPedRelationshipGroupHash(Player, 'PLAYER')
    AddRelationshipGroup('securityGuards')

    for k, v in pairs(Config.SecurityGuards) do
        QBCore.Functions.LoadModel(v['model'])
        securityGuards[k] = CreatePed(26, GetHashKey(v['model']), v['coords'], v['heading'], true, true)
        SetPedRandomComponentVariation(securityGuards[k], 0)
        SetPedRandomProps(securityGuards[k])
        SetEntityAsMissionEntity(securityGuards[k])
        SetEntityVisible(securityGuards[k], true)
        SetPedRelationshipGroupHash(securityGuards[k], 'labpatrol')
        SetPedArmour(securityGuards[k], 100)   
        SetPedCanSwitchWeapon(securityGuards[k], true)
        SetPedFleeAttributes(securityGuards[k], 0, false)
        GiveWeaponToPed(securityGuards[k], randomgun, 999, false, false)
        TaskGoToEntity(securityGuards[k], Player, -1, 1.0, 10.0, 1073741824.0, 0)
        SetPedAccuracy(securityGuards[k], Config.SecurityGuardsAccuracy)
        local random = math.random(1, 2)
        if random == 2 then
            TaskGuardCurrentPosition(securityGuards[k], 10.0, 10.0, 1)
        end
        pedsspawned = true
    end

    SetRelationshipBetweenGroups(0, 'securityGuards', 'securityGuards')
    SetRelationshipBetweenGroups(5, 'securityGuards', 'PLAYER')
    SetRelationshipBetweenGroups(5, 'PLAYER', 'securityGuards')
end

local function DeletePeds()
    for i = 1, #securityGuards do
        DeleteEntity(securityGuards[i])
    end
    pedsspawned = false
end

RegisterNetEvent("f-warehouseHeist:client:spawnguards", function()
    SpawnGuardsLab()
end)

RegisterNetEvent("f-warehouseHeist:client:deleteguards", function()
    DeletePeds()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if pedsspawned then
        DeletePeds()
    end
end)