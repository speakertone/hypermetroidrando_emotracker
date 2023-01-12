-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true
-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", "true")
end
print("---------------------------------------------------------------------")
print("")

U8_READ_CACHE = 0
U8_READ_CACHE_ADDRESS = 0

U16_READ_CACHE = 0
U16_READ_CACHE_ADDRESS = 0

-- ************************** Memory reading helper functions

function InvalidateReadCaches()
    U8_READ_CACHE_ADDRESS = 0
    U16_READ_CACHE_ADDRESS = 0
end

function ReadU8(segment, address)
    if U8_READ_CACHE_ADDRESS ~= address then
        U8_READ_CACHE = segment:ReadUInt8(address)
        U8_READ_CACHE_ADDRESS = address
    end

    return U8_READ_CACHE
end

function ReadU16(segment, address)
    if U16_READ_CACHE_ADDRESS ~= address then
        U16_READ_CACHE = segment:ReadUInt16(address)
        U16_READ_CACHE_ADDRESS = address
    end

    return U16_READ_CACHE
end

-- *************************** Game status

function isInGame()
    local mainModuleIdx = AutoTracker:ReadU8(0x7e0998, 0)

    local inGame = (mainModuleIdx >= 0x07 and mainModuleIdx <= 0x12)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("*** In-game Status: ", '0x7e0998', string.format('0x%x', mainModuleIdx), inGame)
    end
    return inGame
end

-- ******************** Helper functions for updating items and locations

function updateSectionChestCountFromByteAndFlag(segment, locationRef, address, flag, callback)
    local location = Tracker:FindObjectForCode(locationRef)
    if location then
        -- Do not auto-track this if the user has manually modified it
        if location.Owner.ModifiedByUser then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print("* Skipping user modified location: ", locationRef)
            end
            return
        end

        local value = ReadU8(segment, address)
        local check = value & flag

        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Updating chest count:", locationRef, string.format('0x%x', address),
                    string.format('0x%x', value), string.format('0x%x', flag), check ~= 0)
        end

        if check ~= 0 then
            location.AvailableChestCount = 0
            if callback then
                callback(true)
            end
        else
            location.AvailableChestCount = location.ChestCount
            if callback then
                callback(false)
            end
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("***ERROR*** Couldn't find location:", locationRef)
    end
end

function updateAmmoFrom2Bytes(segment, code, address)
    local item = Tracker:FindObjectForCode(code)
    local value = ReadU16(segment, address)

    if item then
        if code == "etank" then
            if value > 1499 then
                item.AcquiredCount = 14
            else
                item.AcquiredCount = value/100
            end
        elseif code == "reservetank" then
            if value > 500 then
                item.AcquiredCount = 5
            else
                item.AcquiredCount = value/100
            end
        else
            item.AcquiredCount = value
        end

        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Ammo:", item.Name, string.format("0x%x", address), value, item.AcquiredCount)
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("***ERROR*** Couldn't find item: ", code)
    end
end

function updateToggleItemFromByteAndFlag(segment, code, address, flag)
    local item = Tracker:FindObjectForCode(code)
    if item then
        local value = ReadU8(segment, address)

        local flagTest = value & flag

        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Item:", item.Name, string.format("0x%x", address), string.format("0x%x", value),
                    string.format("0x%x", flag), flagTest ~= 0)
        end

        if flagTest ~= 0 then
            item.Active = true
        else
            item.Active = false
        end
    elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("***ERROR*** Couldn't find item: ", code)
    end
end


-- ************************* Main functions

function updateItems(segment)
    if not isInGame() then
        return false
    end
    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        InvalidateReadCaches()
        local address = 0x7e09a2

        updateToggleItemFromByteAndFlag(segment, "varia", address + 0x02, 0x01)
        updateToggleItemFromByteAndFlag(segment, "spring", address + 0x02, 0x02)
        updateToggleItemFromByteAndFlag(segment, "morph", address + 0x02, 0x04)
        updateToggleItemFromByteAndFlag(segment, "screw", address + 0x02, 0x08)
        updateToggleItemFromByteAndFlag(segment, "gravity", address + 0x02, 0x20)

        updateToggleItemFromByteAndFlag(segment, "hijump", address + 0x03, 0x01)
        updateToggleItemFromByteAndFlag(segment, "space", address + 0x03, 0x02)
        updateToggleItemFromByteAndFlag(segment, "bomb", address + 0x03, 0x10)
        updateToggleItemFromByteAndFlag(segment, "speed", address + 0x03, 0x20)
        updateToggleItemFromByteAndFlag(segment, "grapple", address + 0x03, 0x40)
        updateToggleItemFromByteAndFlag(segment, "xray", address + 0x03, 0x80)

        updateToggleItemFromByteAndFlag(segment, "wave", address + 0x06, 0x01)
        updateToggleItemFromByteAndFlag(segment, "ice", address + 0x06, 0x02)
        updateToggleItemFromByteAndFlag(segment, "spazer", address + 0x06, 0x04)
        updateToggleItemFromByteAndFlag(segment, "plasma", address + 0x06, 0x08)
        updateToggleItemFromByteAndFlag(segment, "charge", address + 0x07, 0x10)

        updateToggleItemFromByteAndFlag(segment, "missile", address + 0x36, 0x01)
        updateToggleItemFromByteAndFlag(segment, "supermissile", address + 0x36, 0x02)
        updateToggleItemFromByteAndFlag(segment, "powerbomb", address + 0x36, 0x04)
    end
    return true
end

function updateAmmo(segment)
    if not isInGame() then
        return false
    end
    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        InvalidateReadCaches()
        local address = 0x7e09c2

        updateAmmoFrom2Bytes(segment, "etank", address + 0x02)
        updateAmmoFrom2Bytes(segment, "ammo", address + 0x06)
        --updateAmmoFrom2Bytes(segment, "missile", address + 0x06)
        --updateAmmoFrom2Bytes(segment, "super", address + 0x0a)
        --updateAmmoFrom2Bytes(segment, "pb", address + 0x0e)
        updateAmmoFrom2Bytes(segment, "reservetank", address + 0x12)
    end
    return true
end

function updateBosses(segment)
    if not isInGame() then
        return false
    end
    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        InvalidateReadCaches()
        local address = 0x7ed828

        updateToggleItemFromByteAndFlag(segment, "kraid", address + 0x1, 0x01)
        updateToggleItemFromByteAndFlag(segment, "ridley", address + 0x2, 0x01)
        updateToggleItemFromByteAndFlag(segment, "phantoon", address + 0x3, 0x01)
        updateToggleItemFromByteAndFlag(segment, "draygon", address + 0x4, 0x01)

        updateToggleItemFromByteAndFlag(segment, "sporespawn", address + 0x1, 0x02)
        updateToggleItemFromByteAndFlag(segment, "crocomire", address + 0x2, 0x02)
        updateToggleItemFromByteAndFlag(segment, "botwoon", address + 0x4, 0x02)
    end
    return true
end

function updateGates(segment)
    if not isInGame() then
        return false
    end
    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        InvalidateReadCaches()
        local address = 0x7ed864

        updateToggleItemFromByteAndFlag(segment, "gate01", address + 0x0, 0x01)
        updateToggleItemFromByteAndFlag(segment, "gate02", address + 0x0, 0x02)
        updateToggleItemFromByteAndFlag(segment, "gate03", address + 0x0, 0x04)
        updateToggleItemFromByteAndFlag(segment, "gate04", address + 0x0, 0x08)
        updateToggleItemFromByteAndFlag(segment, "gate05", address + 0x1, 0x01)
        updateToggleItemFromByteAndFlag(segment, "gate06", address + 0x1, 0x02)
        updateToggleItemFromByteAndFlag(segment, "gate07", address + 0x1, 0x04)
        updateToggleItemFromByteAndFlag(segment, "gate08", address + 0x1, 0x08)
        updateToggleItemFromByteAndFlag(segment, "gate09", address + 0x2, 0x01)
        updateToggleItemFromByteAndFlag(segment, "gate10", address + 0x2, 0x02)
        updateToggleItemFromByteAndFlag(segment, "gate11", address + 0x2, 0x04)
        updateToggleItemFromByteAndFlag(segment, "gate12", address + 0x2, 0x08)
        updateToggleItemFromByteAndFlag(segment, "gate13", address + 0x3, 0x01)
        updateToggleItemFromByteAndFlag(segment, "gate14", address + 0x3, 0x02)
        updateToggleItemFromByteAndFlag(segment, "gate15", address + 0x3, 0x04)
    end
    return true
end

function updateRooms(segment)
    if not isInGame() then
        return false
    end
    if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        InvalidateReadCaches()
        local address = 0x7ed870

        updateSectionChestCountFromByteAndFlag(segment, "@Crateria Ship - Reserve Tank/Major Item", address + 0x0, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Backflip Tutorial/Minor Item", address + 0x0, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Crateria Cliff - Power Bombs/Minor Item", address + 0x0, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Wrecked Ship Entrance - Missiles/Minor Item", address + 0x0, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Intended First Missiles/Minor Item", address + 0x0, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Early Supers/Minor Item", address + 0x0, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Sidehopper Lake/Minor Item", address + 0x0, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Crateria E-Tank/Major Item", address + 0x0, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Pipe Missiles/Minor Item", address + 0x1, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Wave Beam/Major Item", address + 0x1, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@X-Ray/Major Item", address + 0x1, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Wave Beam - Missiles/Minor Item", address + 0x1, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Walljump Missiles/Minor Item", address + 0x1, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Wall Chozo/Minor Item", address + 0x1, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Morphing Ball/Major Item", address + 0x1, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Brinstar - Reserves/Major Item", address + 0x1, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Space Jump/Major Item", address + 0x2, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Upper Brinstar - E-tank/Major Item", address + 0x2, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Kago Lake - Supers/Minor Item", address + 0x2, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Spore Spawn - E-tank/Major Item", address + 0x2, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Grate - Power Bombs/Minor Item", address + 0x2, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Spore Spawn Missiles/Minor Item", address + 0x2, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Caterpillar Missiles/Minor Item", address + 0x2, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Grapple Tower Blue - Missiles/Minor Item", address + 0x2, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Mini-Kraid E-tank/Major Item", address + 0x3, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Red Grapple Tower/Major Item", address + 0x3, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Bomb Tower - Middle/Minor Item", address + 0x3, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Bomb Tower - Right/Minor Item", address + 0x3, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Hi-Jump Boots/Major Item", address + 0x3, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Blue Ripper Tower/Minor Item", address + 0x3, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Grapple Beam/Major Item", address + 0x3, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Bomb Torizo/Major Item", address + 0x3, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Charge Beam/Major Item", address + 0x4, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Crossroads - Missiles/Minor Item", address + 0x4, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Frog - E-tank/Major Item", address + 0x4, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Lava Maze - Cliff Supers/Minor Item", address + 0x4, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Speedbooster/Major Item", address + 0x4, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@LN Elevator - Left Missile/Minor Item", address + 0x4, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Ridley Supers/Minor Item", address + 0x4, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@LN Elevator - E-tank/Major Item", address + 0x4, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@LN Elevator - Right Missile/Minor Item", address + 0x5, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Norfair - Speed Valley/Minor Item", address + 0x5, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Ice - E-tank/Major Item", address + 0x5, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@LN Speed Challenge/Minor Item", address + 0x5, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Missile Tower - Middle/Minor Item", address + 0x5, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Norfair - Reserves/Major Item", address + 0x5, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Metroid Chozo/Minor Item", address + 0x5, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Teaser Supers/Minor Item", address + 0x5, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Mining Quarry - Intended Supers/Minor Item", address + 0x6, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Missile Tower - Lower/Minor Item", address + 0x6, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Missile Tower - Ridley Statue/Minor Item", address + 0x6, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Ice Beam/Major Item", address + 0x6, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Boulder Supers/Minor Item", address + 0x6, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Boulder Hallway - Missiles/Minor Item", address + 0x6, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Crocomire - Missiles/Minor Item", address + 0x6, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Lava Dive - E-tank/Major Item", address + 0x6, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Varia Suit/Major Item", address + 0x7, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Wrecked Ship Attic - E-tank/Major Item", address + 0x7, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Conveyor Belt Robots/Minor Item", address + 0x7, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Green Tower - Supers/Minor Item", address + 0x7, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Spike Tunnel/Minor Item", address + 0x7, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Acid Lake - Cliff Missiles/Minor Item", address + 0x7, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Dead Spike - Missiles/Minor Item", address + 0x7, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Phantoon E-tank/Major Item", address + 0x7, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Outer Maze/Minor Item", address + 0x8, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Moss Maze/Minor Item", address + 0x8, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Wrecked Ship - Reserves/Major Item", address + 0x8, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Botwoon - Power Bombs/Minor Item", address + 0x8, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Botwoon Bridge/Minor Item", address + 0x8, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Maridia Depths - Power Bombs/Minor Item", address + 0x8, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Turtle Reserves/Major Item", address + 0x8, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Botwoon Cove - Missile/Minor Item", address + 0x9, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Pirate E-tank/Major Item", address + 0x9, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Gravity Suit/Major Item", address + 0x9, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Spike-Sand Valley/Minor Item", address + 0x9, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Maridia Tube - E-tank/Major Item", address + 0x9, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Maridia Ruins - Left Missile/Minor Item", address + 0x9, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Maridia Ruins - Right Missile/Minor Item", address + 0x9, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Shaktool Simulator/Minor Item", address + 0x9, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Maridia Tube - Missile/Minor Item", address + 0xa, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@12th Street - Missile/Minor Item", address + 0xa, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@13th Street - Supers/Minor Item", address + 0xa, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Draygon - Chozo Hoard/Major Item", address + 0xa, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Sandfall Maze - Supers/Minor Item", address + 0xa, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Plasma - Power Bombs/Minor Item", address + 0xa, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@Plasma Beam/Major Item", address + 0xa, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Screw Attack/Major Item", address + 0xa, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Bowling Chozo/Minor Item", address + 0xb, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@Spring Ball/Major Item", address + 0xb, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Sandfall Missiles/Minor Item", address + 0xb, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Coral Speedway/Minor Item", address + 0xb, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Spazer Beam/Major Item", address + 0xb, 0x10)
        updateSectionChestCountFromByteAndFlag(segment, "@Teaser Missiles/Minor Item", address + 0xb, 0x20)
        updateSectionChestCountFromByteAndFlag(segment, "@GT Supers/Minor Item", address + 0xb, 0x40)
        updateSectionChestCountFromByteAndFlag(segment, "@Kraid Supers/Minor Item", address + 0xb, 0x80)

        updateSectionChestCountFromByteAndFlag(segment, "@Dachora Missiles/Minor Item", address + 0xc, 0x01)
        updateSectionChestCountFromByteAndFlag(segment, "@LN Warehouse/Minor Item", address + 0xc, 0x02)
        updateSectionChestCountFromByteAndFlag(segment, "@Tunnel Missiles/Minor Item", address + 0xc, 0x04)
        updateSectionChestCountFromByteAndFlag(segment, "@Mining Quarry - Missiles/Minor Item", address + 0xc, 0x08)
        updateSectionChestCountFromByteAndFlag(segment, "@Chozo Lake - Missiles/Minor Item", address + 0xc, 0x10)

        --updateSectionChestCountFromByteAndFlag(segment, "@Crossroads - Missiles/Minor Item", address + 0x1f, 0x80)
    end
    return true
end


-- *************************** Setup memory watches

ScriptHost:AddMemoryWatch("HM Item Data", 0x7e09a0, 0x80, updateItems)
ScriptHost:AddMemoryWatch("HM Ammo Data", 0x7e09c2, 0x16, updateAmmo)
ScriptHost:AddMemoryWatch("HM Boss Data", 0x7ed828, 0x08, updateBosses)
ScriptHost:AddMemoryWatch("HM Gate Data", 0x7ed864, 0x80, updateGates)
ScriptHost:AddMemoryWatch("HM Room Data", 0x7ed870, 0x20, updateRooms)
