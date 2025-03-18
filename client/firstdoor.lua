local QBCore = exports['qb-core']:GetCoreObject()

local IdProp
local isParticlePlaying = false
local particleId = nil
local thermitePropCoords = nil
local doorStates = {
    entranceDoorOpen = false,
    isDoorHacked = false
}

local function ReviveFirstDoorHack()
    exports['qb-target']:AddBoxZone("EntranceDoor", vector3(982.63, -2281.10, 30.65), 1.0, 1.5, {
        name = "EntranceDoor",
        heading = 85.113,
        debugPoly = false,
        minZ = 30.0,
        maxZ = 31.5,
    }, {
        options = {
            {
                type = "client",
                event = "f-warehouseHeist:client:firstdoorhack",
                icon = "fas fa-user-secret",
                label = "Hack",
            },
        },
        distance = 2.5
    })
end

local function StartParticleEffect()
    if not isParticlePlaying then
        RequestNamedPtfxAsset("scr_ornate_heist")
        while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
            Wait(0)
        end
        SetPtfxAssetNextCall("scr_ornate_heist")
        local coords = GetEntityCoords(thermitePropCoords)
        particleId = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", coords.x, coords.y + 1, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        isParticlePlaying = true
    end
end

local function EndParticleEffect()
    if isParticlePlaying and particleId ~= nil then
        StopParticleFxLooped(particleId, true)
        particleId = nil
        isParticlePlaying = false
    end
end

local function GetDoorState()
    QBCore.Functions.TriggerCallback('f-warehouseHeist:server:GetDoorState', function(state)
        doorStates = state
    end)
end

RegisterNetEvent("f-warehouseHeist:client:FullResetHeist", function()
    TriggerServerEvent('f-warehouseHeist:server:UpdateDoorState', {
        entranceDoorOpen = false,
        isDoorHacked = false
    })
    ReviveFirstDoorHack()
    TriggerEvent("f-warehouseHeist:client:deleteguards")
end)

RegisterNetEvent('f-warehouseHeist:client:SyncDoorState', function(state)
    doorStates.entranceDoorOpen = state.entranceDoorOpen
    doorStates.isDoorHacked = state.isDoorHacked
end)

RegisterNetEvent("f-warehouseHeist:client:firstdoorhack", function()
    local ped = PlayerPedId()
    local HackItem = Config.HackItem
    local hasItem = QBCore.Functions.HasItem(HackItem)

    local pedco = GetEntityCoords(ped)
    local boneIndex = GetPedBoneIndex(ped, 28422)
    local panel = GetClosestObjectOfType(pedco, 4.0, Config.EntrenceDoor.Object, false, false, false)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(982.66, -2281.585, 30.51, rotx, roty, rotz, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 83.51, -2281.99, 30.51, true, true, false)
    QBCore.Functions.TriggerCallback('f-warehouseHeist:server:GetPoliceCount', function(policeCount)
        if hasItem then
            if not doorStates.isDoorHacked then
                if policeCount >= Config.RequiredPDOnDuty.amount then
                    RequestModel("hei_prop_heist_thermite")
                    while not HasModelLoaded("hei_prop_heist_thermite") do Wait(10) end
                    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
                    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do Wait(10) end
                    Wait(100)
                    TaskGoStraightToCoord(ped, 983.51, -2281.99, 30.51, 1, 1000, 86.1, 0)
                    Wait(3000)
                    local IdProp = CreateObject('hei_prop_heist_thermite', pedco, true, true, false)
                    thermitePropCoords = IdProp
                    AttachEntityToEntity(IdProp, ped, boneIndex, 0.0, 0.028, 0.001, 190.0, 175.0, 0.0, true, true, false, true, 1, true)
                    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
                    NetworkStartSynchronisedScene(bagscene)
                    Wait(5700)
                    AttachEntityToEntity(IdProp, panel, boneIndex, -1.08, -0.09, -0.08, 270.0, 0.0, 180.0, true, true, false, true, 1, true)
                    FreezeEntityPosition(IdProp)
                    Wait(500)
                    ClearPedTasksImmediately(ped)
                    DeleteObject(bag)

                    local hacksuccess = exports.bl_ui:Untangle(Config.Thermitehack.iterations, {
                        numberOfNodes = Config.Thermitehack.numberOfNodes,
                        duration = Config.Thermitehack.duration * 1000,
                    })
                    if hacksuccess then
                        QBCore.Functions.Notify("You passed the hack the door will now open soon", "success", 5000)
                        TriggerServerEvent("f-warehouseHeist:server:RemoveThermite")
                        TriggerEvent("f-warehouseHeist:client:spawnlootboxes")
                        TriggerEvent("f-warehouseHeist:client:spawnguards")
                        StartParticleEffect()
                        Wait(10000)
                        EndParticleEffect()
                        TriggerEvent("f-warehouseHeist:client:alertcops")
                        TriggerServerEvent("f-warehouseHeist:server:HeistStarted")

                        TriggerServerEvent('f-warehouseHeist:server:UpdateDoorState', {
                            entranceDoorOpen = true,
                            isDoorHacked = true
                        })
                        DeleteObject(IdProp)
                        exports['qb-target']:RemoveZone("EntranceDoor")
                    else
                        TriggerServerEvent("f-warehouseHeist:server:RemoveThermite")
                        DeleteObject(IdProp)
                        QBCore.Functions.Notify("You failed the hack", "error", 5000)
                    end
                else
                    QBCore.Functions.Notify("Not enough police on duty", "error", 5000)
                end
            else
                QBCore.Functions.Notify("The door has already been Hacked", "error", 5000)
            end
        else
            QBCore.Functions.Notify("You dont have the requied tools to hack the door", "error", 5000)
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(3000)
        -- First Door
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local EntranceDoorObject = Config.EntrenceDoor.Object
        local EntranceDoorDist = #(pos - Config.EntrenceDoor.coords)
        if EntranceDoorDist < 50 then
            if EntranceDoorObject == Config.EntrenceDoor.Object then
                EntranceDoorObject = GetClosestObjectOfType(Config.EntrenceDoor.coords.xyz, 5.0, Config.EntrenceDoor.Object, false, false, false)
            end
            if EntranceDoorObject ~= 0 then
                if doorStates.entranceDoorOpen then
                    FreezeEntityPosition(EntranceDoorObject, false)
                else
                    SetEntityHeading(EntranceDoorObject, Config.EntrenceDoor.Closed)
                    FreezeEntityPosition(EntranceDoorObject, true)
                end
            end
        else
            EntranceDoorObject = Config.EntrenceDoor.Object
        end
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("EntranceDoor", vector3(982.63, -2281.10, 30.65), 1.0, 1.5, {
        name = "EntranceDoor",
        heading = 85.113,
        debugPoly = false,
        minZ = 30.0,
        maxZ = 31.5,
    }, {
        options = {
            {
                type = "client",
                event = "f-warehouseHeist:client:firstdoorhack",
                icon = "fas fa-user-secret",
                label = "Hack",
            },
        },
        distance = 2.5
    })
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    DeleteObject(IdProp)
end)