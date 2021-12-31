local QBCore = exports['qb-core']:GetCoreObject()
local inBenny = false

CreateThread(function()
    while true do
        Wait(1000)
        if not IsPedInAnyVehicle(PlayerPedId()) and inBenny then         
            exports['qb-radialmenu']:AddOption(5)
        end
    end
end)

RegisterNetEvent("qb-benny:client:repair", function()
    SendNUIMessage({sound = "wrench", volume = 1.0})
    QBCore.Functions.Progressbar("repair_car", "Repairing Vehicle...", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('iens:repaira')
        TriggerEvent('vehiclemod:client:fixEverything')
    end)
end)

local benny = PolyZone:Create({
    vector2(-50.17, -1067.12),
    vector2(-37.61, -1031.66),
    vector2(-8.56, -1038.22),
    vector2(-21.38, -1077.61),
  }, {
    name="benny",
    minZ = 25.0,
    maxZ = 35.0
})

benny:onPlayerInOut(function(isPointInside)
    if isPointInside then
        inBenny = true
        if IsPedInAnyVehicle(PlayerPedId()) then 
            exports['qb-radialmenu']:AddOption(5, {
                id = 'benny',
                title = 'Repair',
                icon = 'car-crash',
                type = 'server',
                event = 'qb-benny:server:repair',
                shouldClose = true
            })
        end
    else
        inBenny = false
        exports['qb-radialmenu']:RemoveOption(5)
    end
end)
