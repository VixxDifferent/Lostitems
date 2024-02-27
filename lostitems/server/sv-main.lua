ESX = exports.es_extended:getSharedObject()

RegisterCommand('lostitems', function (source, args, rawCommand)
    local source = source
    local inventoryItems = exports.ox_inventory:GetInventoryItems(source) 

    if inventoryItems then
        local player = ESX.GetPlayerFromId(source)
        if player then 
        local player = ESX.GetPlayerFromId(source)
        local charName = player.getName()
        local date = os.date("%d/%b/%Y %X %p") 
        local dateFormat = string.format('%s', date)

        TriggerClientEvent('chat:addMessage', source, {
            template = '{0}',
            color    =  {50, 205, 50},
            args     =  {'|______' .. charName .. ' (' .. source .. ') Lost Items______|'}
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

if Config.ShowItemsOnDeath then 
    RegisterServerEvent('esx:onPlayerDeath')
    AddEventHandler('esx:onPlayerDeath', function(data)

        local source = source
        local inventoryItems = exports.ox_inventory:GetInventoryItems(source) 

        if inventoryItems then
            local player = ESX.GetPlayerFromId(source)
            if player then 
            local player = ESX.GetPlayerFromId(source)
            local charName = player.getName()
            local date = os.date("%d/%b/%Y %X %p")
            local dateFormat = string.format('%s', date)

            TriggerClientEvent('chat:addMessage', source, {
                template = '{0}',
                color    =  {50, 205, 50},
                args     =  {'|______' .. charName .. ' (' .. source .. ') Lost Items______|'}
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

RegisterCommand('returnlostitems', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    local playerId = tonumber(args[1])
    local target = ESX.GetPlayerFromId(playerId)

    if group == 'user' or group == 'tester' or group == 'mod' or group == 'gameadmin' then
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0} You have insufficient permissions to use this command.',
            color = {255, 255, 255},
            args = {'^1ERROR:^0'}
        })
        return
    end

    if not target then
        TriggerClientEvent('chat:addMessage', source, {
            template = '{0} You must enter a valid ID.',
            color = {255, 255, 255},
            args = {'^1ERROR:^0'}
        })
        return
    end

    exports.ox_inventory:ReturnInventory(playerId)

    TriggerClientEvent('ox_lib:notify', source, { 
        description = 'You have returned ' .. target.getName() .. '\'s Lost items.', 
        position = 'top-right', 
        style = { backgroundColor = '#141517', 
        color = '#C1C2C5', 
        ['.description'] = { color = '#909296'}}, 
        type = 'success' 
    })
end)



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
            color    = {255, 255, 255},
            args     = {'^1[!]^0'}
        })
    end)
end
