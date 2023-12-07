ESX = exports["es_extended"]:getSharedObject() -- ESX export

RegisterCommand('lostitems', function (source, args, rawCommand)
    local source = source
    local inventoryItems = exports.ox_inventory:GetInventoryItems(source) -- self-explanatory gets a player's items using ox_inventory.

    if inventoryItems then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local characterName = xPlayer.getName()
        local date = os.date("%d/%b/%Y %X %p") -- d = day, b = month, y = year, p = PM or AM, depending on the time.
        local dateFormat = string.format('%s', date)

        -- Sends a message the player showing their name and a lost items message.
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0}',
            color    =  {50, 205, 50},
            args     =  {'|______' .. characterName .. ' (' .. source .. ') Lost Items______|'}
        })

        for _, item in pairs(inventoryItems) do
            local itemLabel = item.label
            if item.metadata and item.metadata.ammo then
                local ammoCount = item.metadata.ammo
                TriggerClientEvent('chat:addMessage', source, {
                    template = '{0}',
                    color    =  {178, 34, 34},
                    args     =  {'[' .. dateFormat.. '] ^0' .. item.count .. 'x ' .. itemLabel .. ' (' .. ammoCount .. 'x Ammo)' }
                })
            else
               TriggerClientEvent('chat:addMessage', source, {
                    template = '{0}',
                    color    =  {178, 34, 34},
                    args     =  {'[' .. dateFormat.. '] ^0' .. item.count .. 'x ' .. itemLabel}
                })
                end
            end
        end
    end
end)


RegisterCommand('returnlostitems', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    local playerId = tonumber(args[1])

    if group == 'user' or group == 'tester' or group == 'mod' or group == 'gameadmin' then
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0} You have insufficient permissions to use this command.',
            color = {252, 0, 0},
            args = {'ERROR:'}
        })
        return
    end

    if not playerId then
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0} You must enter a valid ID.',
            color = {252, 0, 0},
            args = {'ERROR:'}
        })
        return
    end

    local targetPlayer = ESX.GetPlayerFromId(playerId)

    if not targetPlayer then
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0} You have entered an invalid ID.',
            color = {252, 0, 0},
            args = {'ERROR:'}
        })
        return
    end

    exports.ox_inventory:ReturnInventory(playerId)
    TriggerClientEvent('chat:addMessage', source, {
        template = '{0} You have returned {1}\'s Lost items.',
        color = {252, 0, 0},
        args = {'[!]:', targetPlayer.getName()}
    })
end)


if Config.ShowItemsOnDeath then 
RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)

    local source = source
    local inventoryItems = exports.ox_inventory:GetInventoryItems(source) -- self-explanatory gets a player's items using ox_inventory.

    if inventoryItems then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local characterName = xPlayer.getName()
        local date = os.date("%d/%b/%Y %X %p") -- d = day, b = month, y = year, p = PM or AM, depending on the time.
        local dateFormat = string.format('%s', date)

        -- Sends a message the player showing their name and a lost items message.
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0}',
            color    =  {50, 205, 50},
            args     =  {'|______' .. characterName .. ' (' .. source .. ') Lost Items______|'}
        })

        for _, item in pairs(inventoryItems) do
            local itemLabel = item.label
            if item.metadata and item.metadata.ammo then
                local ammoCount = item.metadata.ammo
                TriggerClientEvent('chat:addMessage', source, {
                    template = '{0}',
                    color    =  {178, 34, 34},
                    args     =  {'[' .. dateFormat.. '] ^0' .. item.count .. 'x ' .. itemLabel .. ' (' .. ammoCount .. 'x bullets)' }
                })
            else
               TriggerClientEvent('chat:addMessage', source, {
                    template = '{0}',
                    color    =  {178, 34, 34},
                    args     =  {'[' .. dateFormat.. '] ^0' .. item.count .. 'x ' .. itemLabel}
                })
                end
            end
        end
    end
end)
end


if Config.takeInv then 
RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local source = source
    exports.ox_inventory:ConfiscateInventory(source)
    end)
end

if Config.DeathMessage then 
    RegisterServerEvent('esx:onPlayerDeath')
    AddEventHandler('esx:onPlayerDeath', function(data)
        local source = source
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0}: You have died and lost your items, use /lostitems to see what you lost.',
            color    = {252, 0, 0},
            args     = {'[!]'}
        })
    end)
end