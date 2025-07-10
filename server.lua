ESX = nil

-- neuer empfohlener Weg ESX zu holen
ESX = exports['es_extended']:getSharedObject()

-- Deine anderen Server-Events hier, z.B.
RegisterServerEvent('sar_objectplacer:returnItem')
AddEventHandler('sar_objectplacer:returnItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addInventoryItem(item, 1)
    end
end)

RegisterServerEvent('sar_objectplacer:removeItem')
AddEventHandler('sar_objectplacer:removeItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.removeInventoryItem(item, count)
    end
end)
