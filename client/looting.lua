local QBCore = exports['qb-core']:GetCoreObject()

local isHeiststarted = false
local box1coords = Config.LootBoxes.box1coords
local box2coords = Config.LootBoxes.box2coords
local box3coords = Config.LootBoxes.box3coords
local box4coords = Config.LootBoxes.box4coords
local safe1coords = Config.LootBoxes.safe1coords

local function SpawnLootBoxes()
    if isHeiststarted then
        exports['qb-target']:AddBoxZone("Box1", box1coords, 2.0, 1.5, {
            name = "Box1",
            heading = 85.113,
            debugPoly = false,
            minZ = 30.0,
            maxZ = 31.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "f-warehouseHeist:client:lootlootbox1",
                    icon = "fas fa-user-secret",
                    label = "Loot Box 1",
                },
            },
            distance = 2.5
        })
        exports['qb-target']:AddBoxZone("Box2", box2coords, 2.0, 1.5, {
            name = "Box2",
            heading = 85.113,
            debugPoly = false,
            minZ = 32.0,
            maxZ = 33.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "f-warehouseHeist:client:lootlootbox2",
                    icon = "fas fa-user-secret",
                    label = "Loot Box 2",
                },
            },
            distance = 3.2
        })
        exports['qb-target']:AddBoxZone("Box3", box3coords, 2.0, 1.5, {
            name = "Box3",
            heading = 85.113,
            debugPoly = false,
            minZ = 30.0,
            maxZ = 31.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "f-warehouseHeist:client:lootlootbox3",
                    icon = "fas fa-user-secret",
                    label = "Loot Box 3",
                },
            },
            distance = 2.5
        })
        exports['qb-target']:AddBoxZone("Box4", box4coords, 2.0, 1.5, {
            name = "Box4",
            heading = 85.113,
            debugPoly = false,
            minZ = 30.0,
            maxZ = 31.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "f-warehouseHeist:client:lootlootbox4",
                    icon = "fas fa-user-secret",
                    label = "Loot Box 4",
                },
            },
            distance = 2.5
        })
        exports['qb-target']:AddBoxZone("Safe1", safe1coords, 1.0, 1.0, {
            name = "Safe1",
            heading = 85.113,
            debugPoly = false,
            minZ = 30.0,
            maxZ = 31.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "f-warehouseHeist:client:lootlootsafe1",
                    icon = "fas fa-user-secret",
                    label = "Loot Safe 1",
                },
            },
            distance = 2.5
        })
    end
end

RegisterNetEvent("f-warehouseHeist:client:lootlootbox1", function()
    QBCore.Functions.Progressbar("LootBox1", "Searching Loot Box 1", 7500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("f-warehouseHeist:server:lootbox1")
        exports['qb-target']:RemoveZone("Box1")
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
    end) 
end)
RegisterNetEvent("f-warehouseHeist:client:lootlootbox2", function()
    QBCore.Functions.Progressbar("LootBox2", "Searching Loot Box 2", 7500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("f-warehouseHeist:server:lootbox2")
        exports['qb-target']:RemoveZone("Box2")
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
    end) 
end)
RegisterNetEvent("f-warehouseHeist:client:lootlootbox3", function()
    QBCore.Functions.Progressbar("LootBox3", "Searching Loot Box 3", 7500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("f-warehouseHeist:server:lootbox3")
        exports['qb-target']:RemoveZone("Box3")
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
    end) 
end)
RegisterNetEvent("f-warehouseHeist:client:lootlootbox4", function()
    QBCore.Functions.Progressbar("LootBox4", "Searching Loot Box 4", 7500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("f-warehouseHeist:server:lootbox4")
        exports['qb-target']:RemoveZone("Box4")
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
    end) 
end)
RegisterNetEvent("f-warehouseHeist:client:lootlootsafe1", function()
    QBCore.Functions.Progressbar("LootSafe1", "Searching Loot Safe 1", 7500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()
        TriggerServerEvent("f-warehouseHeist:server:lootboxsafe1")
        exports['qb-target']:RemoveZone("Safe1")
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
    end) 
end)


RegisterNetEvent("f-warehouseHeist:client:spawnlootboxes", function()
    isHeiststarted = true
    SpawnLootBoxes()
end)