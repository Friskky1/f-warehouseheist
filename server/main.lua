local QBCore = exports['qb-core']:GetCoreObject()

local raidcooldown = Config.HeistCoolDown * 60
local islootbox1looted = false
local islootbox2looted = false
local islootbox3looted = false
local islootbox4looted = false
local islootsafe1looted = false

local findweaponsodds = math.random(1, 10)
local findweaponschance = 8 -- this number has to be between the numbers listed in the math.random above
local FoundWeapon = Config.Lootboxrewards["weapons"][math.random(1, #Config.Lootboxrewards["weapons"])]
local SafeWeapons = Config.Lootboxrewards["safeweapons"][math.random(1, #Config.Lootboxrewards["safeweapons"])]
local OtherItems = Config.Lootboxrewards["otheritems"][math.random(1, #Config.Lootboxrewards["otheritems"])]

local function ResetHeist()
    islootbox1looted = false
    islootbox2looted = false
    islootbox3looted = false
    islootbox4looted = false
    islootsafe1looted = false
end

local function Heistcooldown()
    while true do 
        if raidcooldown <= 1 then
            raidcooldown = Config.HeistCoolDown * 60
                TriggerClientEvent("f-warehouseHeist:client:FullResetHeist", -1)
                ResetHeist()
                break
            else
                raidcooldown = raidcooldown - 1
            Wait(1000)
        end
        Wait(0)
    end
end

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
    Player.Functions.RemoveItem(Config.HackItem, 1)
    TriggerClientEvent('qb-inventory:client:ItemBox', src, Config.HackItem, 'remove', 1)
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox1", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not islootbox1looted then
        if findweaponschance <= findweaponsodds then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
            Player.Functions.AddItem(FoundWeapon[1], FoundWeapon[2])
        end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
        Player.Functions.AddItem(OtherItems[1], OtherItems[2])
        islootbox1looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox2",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not islootbox2looted then
        if findweaponschance <= findweaponsodds then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
            Player.Functions.AddItem(FoundWeapon[1], FoundWeapon[2])
        end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
        Player.Functions.AddItem(OtherItems[1], OtherItems[2])
        islootbox2looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox3",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not islootbox3looted then
        if findweaponschance <= findweaponsodds then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
            Player.Functions.AddItem(FoundWeapon[1], FoundWeapon[2])
        end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
        Player.Functions.AddItem(OtherItems[1], OtherItems[2])
        islootbox3looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootbox4",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not islootbox4looted then
        if findweaponschance <= findweaponsodds then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[FoundWeapon[1]], "add")
            Player.Functions.AddItem(FoundWeapon[1], FoundWeapon[2])
        end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
        Player.Functions.AddItem(OtherItems[1], OtherItems[2])
        islootbox4looted = true
    end
end)

RegisterNetEvent("f-warehouseHeist:server:lootboxsafe1",function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local cash = math.random(Config.SafeRewardCashAmount[1], Config.SafeRewardCashAmount[2])
    local markedbillbagrewardamount = math.random(Config.AmountOfMarkedBillsToGet[1], Config.AmountOfMarkedBillsToGet[2])
    local info = {worth = math.random(Config.SafeRewardAmount[1], Config.SafeRewardAmount[2])}

    if not islootsafe1looted then
        if findweaponschance <= findweaponsodds then
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[SafeWeapons[1]], "add", 2)
            Player.Functions.AddItem(SafeWeapons[1], SafeWeapons[2] * 2)
        end
        if Config.UseMarkedBills then
            if Player.Functions.AddItem('markedbills', markedbillbagrewardamount, false, info) then
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add", markedbillbagrewardamount)
            end
        else
            Player.Functions.AddMoney("cash", cash, "Safe Reward Money")
        end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[OtherItems[1]], "add")
        Player.Functions.AddItem(OtherItems[1], OtherItems[2] * 2)
        islootsafe1looted = true
    end
end)
