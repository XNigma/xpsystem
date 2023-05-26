Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerEvent('xpsystem:senddata')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Cooldown)
        TriggerServerEvent('addxp')
    end
end)

function SetDisplay(bool)
    SendNUIMessage({
        type = "show",
        status = bool,
    })
    SetNuiFocus(bool, bool)
end

RegisterCommand('xpstore', function(source, args)
    SetDisplay(true)
end)

RegisterNetEvent('xpsystem:senddata', function(xpn, leveln, xpcoins)
    ESX.TriggerServerCallback('xpsystem:getdata', function(info)
        SendNUIMessage({action = 'update', type = 'xp', data = {value = info.xp}})
        SendNUIMessage({action = 'update', type = 'level', data = {value = info.level}})
        SendNUIMessage({action = 'update', type = 'coins', data = {value = info.xpcoins}})
    end)
end)

RegisterNUICallback("close", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("wab", function(data)
    local itemtype = 'waterandbread'
    local price = 100
    TriggerServerEvent('additems', itemtype, price)
end)

RegisterNUICallback("armor", function(data)
    local itemtype = 'armor'
    local price = 250
    TriggerServerEvent('additems', itemtype, price)
end)

RegisterNUICallback("pistol", function(data)
    local itemtype = 'pistol'
    local price = 400
    TriggerServerEvent('additems', itemtype, price)
end)

RegisterNUICallback("money", function(data)
    local itemtype = 'money'
    local price = 500
    TriggerServerEvent('additems', itemtype, price)
end)

RegisterNUICallback("bmoney", function(data)
    local itemtype = 'bmoney'
    local price = 1000
    TriggerServerEvent('additems', itemtype, price)
end)

RegisterNUICallback("assrifle", function(data)
    local itemtype = 'assrifle'
    local price = 2500
    TriggerServerEvent('additems', itemtype, price)
end)

RegisterNUICallback("fpack", function(data)
    local itemtype = 'fpack'
    local price = 4000
    TriggerServerEvent('additems', itemtype, price)
end)

RegisterNUICallback("gpack", function(data)
    local itemtype = 'gpack'
    local price = 5000
    TriggerServerEvent('additems', itemtype, price)
end)