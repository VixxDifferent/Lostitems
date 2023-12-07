ESX = exports["es_extended"]:getSharedObject()

AddEventHandler('esx:onPlayerDeath', function(data)
    TriggerServerEvent('esx:onPlayerDeath')
end)