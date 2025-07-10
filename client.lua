local placedObjects = {}

local function NormalizeAngle(angle)
    return (angle + 360) % 360
end

local function DrawControlsHelp()
    exports.lation_ui:showText({
        title = Config.transl.title,
        description = Config.transl.description,
        options = {
            { label = Config.transl.forward, icon = 'fas fa-arrow-up', keybind = 'W' },
            { label = Config.transl.backward, icon = 'fas fa-arrow-down', keybind = 'S' },
            { label = Config.transl.left, icon = 'fas fa-arrow-left', keybind = 'A' },
            { label = Config.transl.right, icon = 'fas fa-arrow-right', keybind = 'D' },
            { label = Config.transl.rotate_left, icon = 'fas fa-rotate-left', keybind = 'Q' },
            { label = Config.transl.rotate_right, icon = 'fas fa-rotate-right', keybind = 'E' },
            { label = Config.transl.cancel, icon = 'fas fa-xmark', iconColor = '#EF4444', keybind = 'X' },
            { label = Config.transl.confirm, icon = 'fas fa-check', iconColor = '#10B981', keybind = 'ENTER' },
        }
    })
end

RegisterNetEvent('custom:placeObject', function(args)
    local item = args.name
    if not item then
        return
    end

    local objData = Config.Objects[item]
    if not objData then
        return
    end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local forward = GetEntityForwardVector(playerPed)
    local objCoords = coords + forward * 1.5

    local model = GetHashKey(objData.model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    if not IsModelValid(model) then
        return
    end

    local obj = CreateObject(model, objCoords.x, objCoords.y, objCoords.z - 1.0, true, true, false)
    PlaceObjectOnGroundProperly(obj)
    local heading = GetEntityHeading(playerPed)
    SetEntityHeading(obj, heading)
    FreezeEntityPosition(obj, true)
    SetEntityInvincible(obj, true)

    local pos = GetEntityCoords(obj)
    local rot = GetEntityRotation(obj, 2) -- Rotation order ZYX

    DrawControlsHelp()

    local placing = true
    while placing do
        Wait(0)

        -- Spielerbewegung sperren (außer Q/E fürs Drehen)
        DisableControlAction(0, 30, true) -- Links/Rechts bewegen (A/D)
        DisableControlAction(0, 31, true) -- Vorwärts/Rückwärts (W/S)
        DisableControlAction(0, 21, true) -- Sprinten
        DisableControlAction(0, 22, true) -- Springen
        DisableControlAction(0, 23, true) -- Enter Vehicle (F)
        DisableControlAction(0, 24, true) -- Angriff
        DisableControlAction(0, 25, true) -- Zielen
        DisableControlAction(0, 36, true) -- Ducken

        -- Objekt bewegen mit WASD
        if IsControlPressed(0, 32) then pos = pos + GetEntityForwardVector(obj) * 0.05 end -- W
        if IsControlPressed(0, 33) then pos = pos - GetEntityForwardVector(obj) * 0.05 end -- S

        local forwardVec = GetEntityForwardVector(obj)
        local left = vector3(-forwardVec.y, forwardVec.x, 0)
        local right = vector3(forwardVec.y, -forwardVec.x, 0)

        if IsControlPressed(0, 34) then pos = pos + left * 0.05 end -- A
        if IsControlPressed(0, 35) then pos = pos + right * 0.05 end -- D

        -- Objekt drehen mit Q/E um Z-Achse
        if IsControlPressed(0, 44) then -- Q
            rot = vector3(rot.x, rot.y, (rot.z - 1) % 360)
        end
        if IsControlPressed(0, 38) then -- E
            rot = vector3(rot.x, rot.y, (rot.z + 1) % 360)
        end

        SetEntityCoordsNoOffset(obj, pos.x, pos.y, pos.z, true, true, true)
        SetEntityRotation(obj, rot.x, rot.y, rot.z, 2, true)

        -- Abbrechen mit X
        if IsControlJustPressed(0, 73) then
            DeleteEntity(obj)
            exports.lation_ui:hideText()
            exports.lation_ui:notify({
                title = Config.transl.cancel_title,
                message = objData.label .. ' ' .. Config.transl.cancel_msg,
                type = 'error',
                position = 'top',
            })
            placing = false
            return
        end

        -- Bestätigen mit Enter
        if IsControlJustPressed(0, 18) then
            exports.lation_ui:hideText()
            FreezeEntityPosition(obj, false)
            SetEntityInvincible(obj, false)

            placedObjects[obj] = item

            exports.ox_target:addLocalEntity(obj, {
                {
                    name = 'pickup_' .. item,
                    icon = 'fa-hand-paper',
                    label = Config.transl.collect,
                    onSelect = function()
                        DeleteEntity(obj)
                        placedObjects[obj] = nil
                        TriggerServerEvent('sar_objectplacer:returnItem', item)
                        exports.lation_ui:notify({
                            title = Config.transl.removed_title,
                            message = objData.label .. ' ' .. Config.transl.removed_msg,
                            type = 'success',
                            position = 'top',
                        })
                    end
                }
            })

            exports.lation_ui:notify({
                title = Config.transl.placed_title,
                message = objData.label .. ' ' .. Config.transl.placed_msg,
                type = 'success',
                position = 'top',
            })

            TriggerServerEvent('sar_objectplacer:removeItem', item, 1)
            placing = false
        end
    end
end)
