local QBCore = exports['qb-core']:GetCoreObject()

local raidcooldown = Config.HeistCoolDown * 60
local islootbox1looted = false
local islootbox2looted = false
local islootbox3looted = false
local islootbox4looted = false
local islootsafe1looted = false
local findweaponsodds = math.random(1, 10)
local findweaponschance = 8 -- this number has to be between the numbers listed in the math.random above
local inventoryType = Config.Inventory
local doorStates = {
    entranceDoorOpen = false,
    isDoorHacked = false
}
local heistState = {
    isHeistStarted = false,
    lootStates = {
        box1 = false,
        box2 = false,
        box3 = false,
        box4 = false,
        safe1 = false
    }
}

RegisterServerEvent('f-warehouseHeist:server:StartHeist', function()
    heistState.isHeistStarted = true
    TriggerClientEvent('f-warehouseHeist:client:SyncHeistState', -1, heistState)
end)

RegisterServerEvent('f-warehouseHeist:server:UpdateLootState', function(lootId)
    if heistState.lootStates[lootId] ~= nil then
        heistState.lootStates[lootId] = true
        TriggerClientEvent('f-warehouseHeist:client:SyncLootState', -1, lootId, true)
    end
end)

QBCore.Functions.CreateCallback('f-warehouseHeist:server:GetHeistState', function(source, cb)
    cb(heistState)
end)

QBCore.Functions.CreateCallback('f-warehouseHeist:server:GetPoliceCount', function(source, cb)
    local policeCount = 0
    for _, player in pairs(QBCore.Functions.GetPlayers()) do
        local playerData = QBCore.Functions.GetPlayer(player)
        if playerData and playerData.PlayerData.job.name == Config.RequiredPDOnDuty.policejobname and playerData.PlayerData.job.onduty then
            policeCount = policeCount + 1
        end
    end
    cb(policeCount)
end)

local function ResetHeist()
    heistState.isHeistStarted = false
    heistState.lootStates.box1 = false
    heistState.lootStates.box2 = false
    heistState.lootStates.box3 = false
    heistState.lootStates.box4 = false
    heistState.lootStates.safe1 = false

    islootbox1looted = false
    islootbox2looted = false
    islootbox3looted = false
    islootbox4looted = false
    islootsafe1looted = false

    TriggerClientEvent('f-warehouseHeist:client:ResetHeistState', -1, heistState)
    TriggerClientEvent("f-warehouseHeist:client:deleteguards", -1)
end


local function Heistcooldown()
    SetTimeout(Config.HeistCoolDown * 60 * 1000, function()
        ResetHeist()
        TriggerClientEvent("f-warehouseHeist:client:FullResetHeist", -1)
        if Config.Debug then
            print("Heist reset")
        end
    end)
end


RegisterServerEvent('f-warehouseHeist:server:UpdateDoorState', function(state)
    doorStates.entranceDoorOpen = state.entranceDoorOpen
    doorStates.isDoorHacked = state.isDoorHacked

    TriggerClientEvent('f-warehouseHeist:client:SyncDoorState', -1, doorStates)
end)

QBCore.Functions.CreateCallback('f-warehouseHeist:server:GetDoorState', function(source, cb)
    cb(doorStates)
end)

RegisterNetEvent("f-warehouseHeist:server:HeistStarted", function()
    Heistcooldown()
end)

RegisterServerEvent('f-warehouseHeist:server:ThermitePtfx', function(coords)
    TriggerClientEvent('f-warehouseHeist:client:ThermitePtfx', -1, coords)
end)

RegisterNetEvent("f-warehouseHeist:server:RemoveThermite", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Config.Inventory == "qb" or Config.Inventory == "ps" or Config.Inventory == "lj" then
        exports['qb-inventory']:RemoveItem(src, Config.HackItem, 1, false, false, false)
        TriggerClientEvent('qb-inventory:client:ItemBox', src, Config.HackItem, 'remove', 1)
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:RemoveItem(src, Config.HackItem, 1)
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox1", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local FoundWeapon = Config.Lootboxrewards.weapons[math.random(1, #Config.Lootboxrewards.weapons)]
    local SafeWeapons = Config.Lootboxrewards.safeweapons[math.random(1, #Config.Lootboxrewards.safeweapons)]
    local OtherItems = Config.Lootboxrewards.otheritems[math.random(1, #Config.Lootboxrewards.otheritems)]
    if not Player then return end

    if not islootbox1looted then
        if inventoryType == "qb" or inventoryType == "ps" or inventoryType == "lj" then
            if findweaponschance <= findweaponsodds then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
                exports['qb-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2], false, false, false)
            end
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
            exports['qb-inventory']:AddItem(src, OtherItems[1], OtherItems[2], false, false, false)
            islootbox1looted = true
        elseif Config.Inventory == "qs" then
            if findweaponschance <= findweaponsodds then
                exports['qs-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2])
            end
            exports['qs-inventory']:AddItem(src, OtherItems[1], OtherItems[2])
            islootbox1looted = true
        end
        islootbox1looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox2",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local FoundWeapon = Config.Lootboxrewards.weapons[math.random(1, #Config.Lootboxrewards.weapons)]
    local SafeWeapons = Config.Lootboxrewards.safeweapons[math.random(1, #Config.Lootboxrewards.safeweapons)]
    local OtherItems = Config.Lootboxrewards.otheritems[math.random(1, #Config.Lootboxrewards.otheritems)]
    if not Player then return end

    if not islootbox2looted then
        if inventoryType == "qb" or inventoryType == "ps" or inventoryType == "lj" then
            if findweaponschance <= findweaponsodds then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
                exports['qb-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2], false, false, false)
            end
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
            exports['qb-inventory']:AddItem(src, OtherItems[1], OtherItems[2], false, false, false)
            islootbox2looted = true
        elseif Config.Inventory == "qs" then
            if findweaponschance <= findweaponsodds then
                exports['qs-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2])
            end
            exports['qs-inventory']:AddItem(src, OtherItems[1], OtherItems[2])
            islootbox2looted = true
        end
        islootbox2looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox3",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local FoundWeapon = Config.Lootboxrewards.weapons[math.random(1, #Config.Lootboxrewards.weapons)]
    local SafeWeapons = Config.Lootboxrewards.safeweapons[math.random(1, #Config.Lootboxrewards.safeweapons)]
    local OtherItems = Config.Lootboxrewards.otheritems[math.random(1, #Config.Lootboxrewards.otheritems)]
    if not Player then return end

    if not islootbox3looted then
        if inventoryType == "qb" or inventoryType == "ps" or inventoryType == "lj" then
            if findweaponschance <= findweaponsodds then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
                exports['qb-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2], false, false, false)
            end
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
            exports['qb-inventory']:AddItem(src, OtherItems[1], OtherItems[2], false, false, false)
            islootbox3looted = true
        elseif Config.Inventory == "qs" then
            if findweaponschance <= findweaponsodds then
                exports['qs-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2])
            end
            exports['qs-inventory']:AddItem(src, OtherItems[1], OtherItems[2])
            islootbox3looted = true
        end
        islootbox3looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox4",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local FoundWeapon = Config.Lootboxrewards.weapons[math.random(1, #Config.Lootboxrewards.weapons)]
    local SafeWeapons = Config.Lootboxrewards.safeweapons[math.random(1, #Config.Lootboxrewards.safeweapons)]
    local OtherItems = Config.Lootboxrewards.otheritems[math.random(1, #Config.Lootboxrewards.otheritems)]
    if not Player then return end

    if not islootbox4looted then
        if inventoryType == "qb" or inventoryType == "ps" or inventoryType == "lj" then
            if findweaponschance <= findweaponsodds then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
                exports['qb-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2], false, false, false)
            end
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
            exports['qb-inventory']:AddItem(src, OtherItems[1], OtherItems[2], false, false, false)
            islootbox4looted = true
        elseif Config.Inventory == "qs" then
            if findweaponschance <= findweaponsodds then
                exports['qs-inventory']:AddItem(src, FoundWeapon[1], FoundWeapon[2])
            end
            exports['qs-inventory']:AddItem(src, OtherItems[1], OtherItems[2])
            islootbox4looted = true
        end
        islootbox4looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootboxsafe1", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    -- Ensure variables are defined
    local findweaponschance = math.random(1, 100)
    local findweaponsodds = Config.WeaponOdds or 50
    local cash = math.random(Config.SafeRewardAmount[1], Config.SafeRewardAmount[2])
    local markedbillbagrewardamount = math.random(Config.AmountOfMarkedBillsToGet[1], Config.AmountOfMarkedBillsToGet[2])
    local info = { worth = cash }
    local SafeWeapons = Config.Lootboxrewards.safeweapons[math.random(1, #Config.Lootboxrewards.safeweapons)]
    local OtherItems = Config.Lootboxrewards.otheritems[math.random(1, #Config.Lootboxrewards.otheritems)]

    if not Player then
        print("Error: Could not retrieve Player for src:", src)
        return
    end
    if Config.Debug == true then
        print("Lootbox Safe Event Triggered for Player:", src)
        -- Ensure loot tables are not empty or nil
        if not Config.Lootboxrewards.safeweapons or #Config.Lootboxrewards.safeweapons == 0 then
            print("Error: safeweapons table is empty or nil")
            return
        end
        if not Config.Lootboxrewards.otheritems or #Config.Lootboxrewards.otheritems == 0 then
            print("Error: otheritems table is empty or nil")
            return
        end
        -- Check if selected items exist
        if not QBCore.Shared.Items[SafeWeapons[1]] then
            print("Error: SafeWeapons item does not exist in Shared.Items:", SafeWeapons[1])
            return
        end
        if not QBCore.Shared.Items[OtherItems[1]] then
            print("Error: OtherItems item does not exist in Shared.Items:", OtherItems[1])
            return
        end
    end

    if islootsafe1looted == nil then islootsafe1looted = false end
    if not islootsafe1looted then
        if Config.Inventory == "qb" or Config.Inventory == "ps" or Config.Inventory == "lj" then
            if findweaponschance <= findweaponsodds then
                local success = exports['qb-inventory']:AddItem(src, SafeWeapons[1], SafeWeapons[2], false, false, false)
                if success then
                    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[SafeWeapons[1]], "add", SafeWeapons[2])
                else
                    print("Error: Failed to add SafeWeapon", SafeWeapons[1])
                end
            end
            if Config.UseMarkedBills then
                local success = exports['qb-inventory']:AddItem(src, "markedbills", markedbillbagrewardamount, false, info, false)
                if success then
                    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items["markedbills"], "add", markedbillbagrewardamount)
                else
                    print("Error: Failed to add marked bills")
                end
            else
                Player.Functions.AddMoney("cash", cash, "Safe Reward Money")
            end

            local success = exports['qb-inventory']:AddItem(src, OtherItems[1], OtherItems[2], false, false, false)
            if success then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add", OtherItems[2])
            else
                print("Error: Failed to add OtherItem", OtherItems[1])
            end

        elseif Config.Inventory == "qs" then
            if findweaponschance <= findweaponsodds then
                exports['qs-inventory']:AddItem(src, SafeWeapons[1], SafeWeapons[2])
            end
            if Config.UseMarkedBills then
                exports['qs-inventory']:AddItem(src, "markedbills", markedbillbagrewardamount, nil, info)
            else
                Player.Functions.AddMoney("cash", cash, "Safe Reward Money")
            end
            exports['qs-inventory']:AddItem(src, OtherItems[1], OtherItems[2])
        end

        islootsafe1looted = true
    end
end)

