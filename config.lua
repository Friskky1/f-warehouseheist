Config = Config or {}

Config.Debug = true

Config.HackItem = "thermite"

Config.Inventory = "qb" -- qb, ps, lj and qs inventory compatible (Ox compatible in a upcoming update target and inventory)

Config.Thermitehack = {
    iterations = 1, -- is the amount of iterations the player has to complete
    numberOfNodes = 11, -- Amount of nodes on the hack that you have to move around
    duration = 13, -- seconds you have to complete 1 of the hack(s)
}

Config.RequiredPDOnDuty = {
    amount = 1,
    policejobname = "police" -- the actual name of the job in qb-core/shared/jobs.lua
}

Config.HeistCoolDown = 90 -- (Minutes) Till heist can be hit again

Config.LootBoxes = { -- Only touch if you plan on changing the coords on where the target zones are located to loot the boxes and safe. Otherwise dont touch.
    box1coords = vector3(980.85, -2287.63, 30.43),
    box2coords = vector3(979.81, -2293.51, 32.71),
    box3coords = vector3(966.18, -2285.0, 30.43),
    box4coords = vector3(966.45, -2286.69, 30.43),
    safe1coords = vector3(972.87, -2293.07, 30.47)
}

Config.UseMarkedBills = true -- If you use marked bills then the price of each marked bill will be worth the amount set in Config.SafeRewardAmount if false then it will give you the reward amount in cash
Config.AmountOfMarkedBillsToGet = {1, 3} -- amount of marked bill bags to get upon reward
Config.SafeRewardAmount = {10000, 17500} -- Gives cash to the player when safe is looted if Config.UseMarkedBills = false

Config.Lootboxrewards = {
    weapons = {
        {"weapon_snspistol", 1},
        {"weapon_heavypistol", 1},
    },
    safeweapons = {
        {"weapon_microsmg", 1},
        {"weapon_machinepistol", 1},
    },
    otheritems = {
        {"pistol_ammo", math.random(1,3)},
        {"vodka", math.random(1,3)},
        {"coke_brick", 1},
        {"advancedlockpick", math.random(1,3)},
        {"thermite", math.random(1,2)},
        {"electronickit", math.random(1,2)},
        {"diamond", math.random(1,5)},
        {"goldbar", math.random(1,5)},
        {"armor", math.random(1,2)},
        {"casinochips", math.random(3000,5000)},
    }
}

Config.SecurityGuardsAccuracy = 3 -- out of 100% how accurate guards are (dont recommend going above 5 or else they will have aimbot)
Config.SecurityGuardsWeapon = { -- this must be the weapon hash not just the weapon item name (this randomises between different guns everytime the guards are spawned)
    'WEAPON_PISTOL',
    'WEAPON_COMBATPDW',
}
    
Config.SecurityGuards = { -- Spawned Security guards for when you complete the inital door hack they spawn to guard the loot
    {coords = vector3(982.01, -2265.27, 30.51), heading = 149.5, model = 's_m_y_blackops_01'},
    {coords = vector3(975.15, -2270.61, 30.51), heading = 205.5, model = 's_m_y_blackops_01'},
    {coords = vector3(981.96, -2284.58, 30.51), heading = 69.5, model = 's_m_y_blackops_01'},
    {coords = vector3(970.11, -2282.8, 30.51), heading = 257.5, model = 's_m_y_blackops_01'},
    {coords = vector3(968.91, -2295.13, 30.51), heading = 308.5, model = 's_m_y_blackops_01'},
    {coords = vector3(973.82, -2296.82, 30.51), heading = 335.5, model = 's_m_y_blackops_01'},
}

Config.PDAlerts = "qb" -- qb, ps, cd or custom (Configure to your dispatch system in client/pdalerts.lua)






























Config.EntrenceDoor = { -- Dont Touch Unless you know what your doing (Needed for the initial Hack)
    Object = -780995466,
    Closed = 85.113,
    coords = vector3(982.63, -2280.49, 30.65),
}