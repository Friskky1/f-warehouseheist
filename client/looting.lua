local QBCore = exports['qb-core']:GetCoreObject()

local box1coords = Config.LootBoxes.box1coords
local box2coords = Config.LootBoxes.box2coords
local box3coords = Config.LootBoxes.box3coords
local box4coords = Config.LootBoxes.box4coords
local safe1coords = Config.LootBoxes.safe1coords

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

local function SpawnLootBoxes()
    if heistState.isHeistStarted then
        -- Box 1
        if not heistState.lootStates.box1 then
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
        end

        -- Box 2
        if not heistState.lootStates.box2 then
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
        end

        -- Box 3
        if not heistState.lootStates.box3 then
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
        end

        -- Box 4
        if not heistState.lootStates.box4 then
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
        end

        -- Safe 1
        if not heistState.lootStates.safe1 then
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
end

RegisterNetEvent('f-warehouseHeist:client:SyncHeistState', function(state)
    heistState = state
    if heistState.isHeistStarted then
        SpawnLootBoxes()
    end
end)

RegisterNetEvent('f-warehouseHeist:client:SyncLootState', function(lootId, state)
    -- Check if the loot state is already the same before updating
    if heistState.lootStates[lootId] ~= state then
        heistState.lootStates[lootId] = state
        if state then
            -- Remove the loot box zone after it has been looted
            exports['qb-target']:RemoveZone(lootId)
        else
            -- Optionally, you can add it back to the target if the box isn't looted
            SpawnLootBoxes()  -- Or simply call a function to recheck loot availability
        end
    end
end)

-- Looting event functions
RegisterNetEvent("f-warehouseHeist:client:lootlootbox1", function()
    if not heistState.lootStates.box1 then
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
            -- Trigger server to loot the box and update state
            TriggerServerEvent("f-warehouseHeist:server:lootbox1")
            TriggerServerEvent('f-warehouseHeist:server:UpdateLootState', 'box1')
            -- Inform the client side about the loot state update
            TriggerEvent('f-warehouseHeist:client:SyncLootState', 'box1', true)
        end, function()
            StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        end)
    else
        QBCore.Functions.Notify("This box has already been looted.", "error", 5000)
    end
end)

-- Similar event functions for lootbox2, lootbox3, lootbox4...


-- Looting event functions for Box 2, Box 3, and Box 4

RegisterNetEvent("f-warehouseHeist:client:lootlootbox2", function()
    if not heistState.lootStates.box2 then
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
            -- Trigger server to loot the box and update state
            TriggerServerEvent("f-warehouseHeist:server:lootbox2")
            TriggerServerEvent('f-warehouseHeist:server:UpdateLootState', 'box2')
            -- Inform the client side about the loot state update
            TriggerEvent('f-warehouseHeist:client:SyncLootState', 'box2', true)
        end, function()
            StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        end)
    else
        QBCore.Functions.Notify("This box has already been looted.", "error", 5000)
    end
end)

RegisterNetEvent("f-warehouseHeist:client:lootlootbox3", function()
    if not heistState.lootStates.box3 then
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
            -- Trigger server to loot the box and update state
            TriggerServerEvent("f-warehouseHeist:server:lootbox3")
            TriggerServerEvent('f-warehouseHeist:server:UpdateLootState', 'box3')
            -- Inform the client side about the loot state update
            TriggerEvent('f-warehouseHeist:client:SyncLootState', 'box3', true)
        end, function()
            StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        end)
    else
        QBCore.Functions.Notify("This box has already been looted.", "error", 5000)
    end
end)

RegisterNetEvent("f-warehouseHeist:client:lootlootbox4", function()
    if not heistState.lootStates.box4 then
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
            -- Trigger server to loot the box and update state
            TriggerServerEvent("f-warehouseHeist:server:lootbox4")
            TriggerServerEvent('f-warehouseHeist:server:UpdateLootState', 'box4')
            -- Inform the client side about the loot state update
            TriggerEvent('f-warehouseHeist:client:SyncLootState', 'box4', true)
        end, function()
            StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        end)
    else
        QBCore.Functions.Notify("This box has already been looted.", "error", 5000)
    end
end)



-- Loot Safe 1
RegisterNetEvent("f-warehouseHeist:client:lootlootsafe1", function()
    if not heistState.lootStates.safe1 then
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
            -- Trigger server to loot the safe and update state
            TriggerServerEvent("f-warehouseHeist:server:lootboxsafe1")
            TriggerServerEvent('f-warehouseHeist:server:UpdateLootState', 'safe1')
            -- Inform the client side about the loot state update
            TriggerEvent('f-warehouseHeist:client:SyncLootState', 'safe1', true)
        end, function()
            StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        end)
    else
        QBCore.Functions.Notify("This safe has already been looted.", "error", 5000)
    end
end)

RegisterNetEvent("f-warehouseHeist:client:spawnlootboxes", function()
    TriggerServerEvent('f-warehouseHeist:server:StartHeist')
end)
