RegisterServerEvent('addxp', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerIdentifier = xPlayer.getIdentifier()
    local xpn = MySQL.scalar.await('SELECT xp FROM users WHERE identifier = ?', {playerIdentifier})
    local leveln = MySQL.scalar.await('SELECT level FROM users WHERE identifier = ?', {playerIdentifier})
    local xpcoins = MySQL.scalar.await('SELECT xpcoins FROM users WHERE identifier = ?', {playerIdentifier})

    if xPlayer then
        if xpn >= Config.MaxXp  then 
            MySQL.update.await('UPDATE users SET xp = ? WHERE identifier = ?', {0, playerIdentifier})
            local levelupdate = leveln + 1
            local xpcoinsupdate = xpcoins + Config.AddCoinsperLevel
            MySQL.update.await('UPDATE users SET level = ? WHERE identifier = ?', {levelupdate, playerIdentifier})
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {xpcoinsupdate, playerIdentifier})
        else
            local xpupdate = xpn + Config.XpperCooldown
            MySQL.update.await('UPDATE users SET xp = ? WHERE identifier = ?', {xpupdate, playerIdentifier})
        end
    end
end)


RegisterServerEvent('additems', function(itemtype, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerIdentifier = xPlayer.getIdentifier()
    local xpcoins = MySQL.scalar.await('SELECT xpcoins FROM users WHERE identifier = ?', {playerIdentifier})

    if itemtype == 'waterandbread' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addInventoryItem('bread', 10)
            xPlayer.addInventoryItem('water', 10)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            xPlayer.showNotification('You dont have coins')
        end
    elseif itemtype == 'armor' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addInventoryItem('bulletproof', 1)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            xPlayer.showNotification('You dont have coins')
        end
    elseif itemtype == 'pistol' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addWeapon('weapon_pistol', 200)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            xPlayer.showNotification('You dont have coins')
        end
    elseif itemtype == 'money' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addMoney(10000)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            xPlayer.showNotification('You dont have coins')
        end
    elseif itemtype == 'bmoney' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addAccountMoney('black_money', 50000)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            xPlayer.showNotification('You dont have coins')
        end
    elseif itemtype == 'assrifle' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addWeapon('weapon_assaultrifle', 200)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            xPlayer.showNotification('You dont have coins')
        end
    elseif itemtype == 'fpack' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addInventoryItem('bread', 50)
            xPlayer.addInventoryItem('water', 50)
            xPlayer.addInventoryItem('bulletproof', 10)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            xPlayer.showNotification('You dont have coins')
        end
    elseif itemtype == 'gpack' then
        if price <= xpcoins then
            local clearcoins = xpcoins - price
            xPlayer.addWeapon('weapon_specialcarbine', 200)
            xPlayer.addWeapon('weapon_assaultrifle', 200)
            xPlayer.addWeapon('weapon_carbinerifle', 200)
            xPlayer.addWeapon('weapon_pistol', 200)
            MySQL.update.await('UPDATE users SET xpcoins = ? WHERE identifier = ?', {clearcoins, playerIdentifier})
        else
            TriggerClientEvent('esx:showHelpNotification', source, 'You dont have coins')
        end
    end 
end)

ESX.RegisterServerCallback('xpsystem:getdata', function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerIdentifier = xPlayer.identifier
     MySQL.query('SELECT * FROM users WHERE ?',{playerIdentifier}, function(result)
        if result ~= nil then
            cb(result[1])
        end
    end)
end)