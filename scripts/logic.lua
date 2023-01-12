-- Can haz cheezburger functions

function hasWave()
    local wave = Tracker:ProviderCountForCode("wave")
    if wave >= 1 then
        return 1
    end
    return 0
end

function hasPlasma()
    local plasma = Tracker:ProviderCountForCode("plasma")
    if plasma >= 1 then
        return 1
    end
    return 0
end

function hasCharge()
    local charge = Tracker:ProviderCountForCode("charge")
    if charge >= 1 then
        return 1
    end
    return 0
end

function hasSpazer()
    local charge = Tracker:ProviderCountForCode("spazer")
    if charge >= 1 then
        return 1
    end
    return 0
end

function hasIce()
    local ice = Tracker:ProviderCountForCode("ice")
    if ice >= 1 then
        return 1
    end
    return 0
end

function hasHiJump()
    local hijump = Tracker:ProviderCountForCode("hijump")
    if hijump >= 1 then
        return 1
    end
    return 0
end


function hasSpaceJump()
    local space = Tracker:ProviderCountForCode("space")
    if space >= 1 then
        return 1
    end
    return 0
end

function hasVaria()
    local varia = Tracker:ProviderCountForCode("varia")
    if varia >= 1 then
        return 1
    end
    return 0
end

function hasGravity()
    local gravity = Tracker:ProviderCountForCode("gravity")
    if gravity >= 1 then
        return 1
    end
    return 0
end

function hasGrapple()
    local grapple = Tracker:ProviderCountForCode("grapple")
    if grapple >= 1 then
        return 1
    end
    return 0
end

function hasXray()
    local xray = Tracker:ProviderCountForCode("xray")
    if xray >= 1 then
        return 1
    end
    return 0
end

function hasBasicBombs()
    local bomb = Tracker:ProviderCountForCode("bomb")
    if bomb >= 1 then
        return 1
    end
    return 0
end

function countAmmo()
    --local missileCount = Tracker:ProviderCountForCode("missile")
    --local superCount = Tracker:ProviderCountForCode("super")
    --local pbCount = Tracker:ProviderCountForCode("powerbomb")
    local ammoCount = Tracker:ProviderCountForCode("ammo")
    return ammoCount
end

function hasPowerBombs()
    local powerbomb = Tracker:ProviderCountForCode("powerbomb")
    if powerbomb >= 1 then
        return 1
    end
    return 0
end

function hasBombs()
    if hasBasicBombs() == 1 or hasPowerBombs() == 1 then
        return 1
    end
    return 0
end

function hasMorph()
    local morph = Tracker:ProviderCountForCode("morph")
    if morph >= 1 then
        return 1
    end
    return 0
end

function hasMissiles()
    local missile = Tracker:ProviderCountForCode("missile")
    if missile >= 1 then
        return 1
    end
    return 0
end

function hasSuper()
    local super = Tracker:ProviderCountForCode("super")
    if super >= 1 then
        return 1
    end
    return 0
end

function countTanks()
    local etanks = Tracker:ProviderCountForCode("etank")
    local reservetanks = Tracker:ProviderCountForCode("reservetank")
    return etanks + reservetanks
end

function hasScrewAttack()
    local screw = Tracker:ProviderCountForCode("screw")
    if screw >= 1 then
        return 1
    end
    return 0
end

function hasSpringBall()
    local spring = Tracker:ProviderCountForCode("spring")
    if spring >= 1 then
        return 1
    end
    return 0
end

function hasGravity()
    local gravity = Tracker:ProviderCountForCode("gravity")
    if gravity >= 1 then
        return 1
    end
    return 0
end

function hasSpeedBooster()
    local speed = Tracker:ProviderCountForCode("speed")
    if speed >= 1 then
        return 1
    end
    return 0
end

function hasGate01()
    local gate01 = Tracker:ProviderCountForCode("gate01")
    if gate01 >= 1 then
        return 1
    end
    return 0
end

function hasGate02()
    local gate02 = Tracker:ProviderCountForCode("gate02")
    if gate02 >= 1 then
        return 1
    end
    return 0
end

function hasGate03()
    local gate03 = Tracker:ProviderCountForCode("gate03")
    if gate03 >= 1 then
        return 1
    end
    return 0
end

function hasGate04()
    local gate04 = Tracker:ProviderCountForCode("gate04")
    if gate04 >= 1 then
        return 1
    end
    return 0
end

function hasGate05()
    local gate05 = Tracker:ProviderCountForCode("gate05")
    if gate05 >= 1 then
        return 1
    end
    return 0
end

function hasGate06()
    local gate06 = Tracker:ProviderCountForCode("gate06")
    if gate06 >= 1 then
        return 1
    end
    return 0
end

function hasGate07()
    local gate07 = Tracker:ProviderCountForCode("gate07")
    if gate07 >= 1 then
        return 1
    end
    return 0
end

function hasGate08()
    local gate08 = Tracker:ProviderCountForCode("gate08")
    if gate08 >= 1 then
        return 1
    end
    return 0
end

function hasGate09()
    local gate09 = Tracker:ProviderCountForCode("gate09")
    if gate09 >= 1 then
        return 1
    end
    return 0
end

function hasGate10()
    local gate10 = Tracker:ProviderCountForCode("gate10")
    if gate10 >= 1 then
        return 1
    end
    return 0
end

function hasGate11()
    local gate11 = Tracker:ProviderCountForCode("gate11")
    if gate11 >= 1 then
        return 1
    end
    return 0
end

function hasGate12()
    local gate12 = Tracker:ProviderCountForCode("gate12")
    if gate12 >= 1 then
        return 1
    end
    return 0
end

function hasGate13()
    local gate13 = Tracker:ProviderCountForCode("gate13")
    if gate13 >= 1 then
        return 1
    end
    return 0
end

function hasGate14()
    local gate14 = Tracker:ProviderCountForCode("gate14")
    if gate14 >= 1 then
        return 1
    end
    return 0
end

function hasGate15()
    local gate15 = Tracker:ProviderCountForCode("gate15")
    if gate15 >= 1 then
        return 1
    end
    return 0
end

function hasBeatenSporeSpawn()
    local sporespawn = Tracker:ProviderCountForCode("sporespawn")
    if sporespawn >= 1 then
        return 1
    end
    return 0
end

function hasBeatenCrocomire()
    local crocomire = Tracker:ProviderCountForCode("crocomire")
    if crocomire >= 1 then
        return 1
    end
    return 0
end

function hasBeatenBotwoon()
    local botwoon = Tracker:ProviderCountForCode("botwoon")
    if botwoon >= 1 then
        return 1
    end
    return 0
end

function hasBeatenPhantoon()
    local phantoon = Tracker:ProviderCountForCode("phantoon")
    if phantoon >= 1 then
        return 1
    end
    return 0
end


-- Can do the things functions

function heatProof()
    if hasVaria() == 1 then
        return 1
    end
    return 0
end

function canHellRun()
    if heatProof() == 1 then
        return 1
    elseif countTanks() >= 3 then
        return 1, AccessibilityLevel.SequenceBreak
    end
    return 0
end

function canBomb()
    if hasMorph() == 1 and hasBasicBombs() == 1 then
        return 1
    end
    return 0
end

function canPowerBomb()
    if hasMorph() == 1 and hasPowerBombs() == 1 and countAmmo() >= 20 then
        return 1
    end
    return 0
end

function canFly()
    if hasSpaceJump() == 1 then
        return 1
    elseif canBomb() == 1 then
        return 1, AccessibilityLevel.SequenceBreak
    end
    return 0
end

function canFlyStraightUp()
    if hasSpeedBooster() == 1 then
        return 1
    else
        return canFly()
    end
end

function canOpenRedDoors()
    if hasMissiles() == 1 or hasSuper() == 1 then
        return 1
    end
    return 0
end

function canOpenGreenDoors()
    if hasSuper() == 1 then
        return 1
    end
    return 0
end

function canOpenYellowDoors()
    if canPowerBomb() == 1 then
        return 1
    end
    return 0
end

function canBombWalls()
    if canBomb() == 1 or canPowerBomb() == 1 or hasScrewAttack() == 1 then
        return 1
    end
    return 0
end

function canBombPassages()
    if canBomb() == 1 or canPowerBomb() == 1 then
        return 1
    end
    return 0
end

function canDoSuitlessMaridia()
    if hasHiJump() == 1 and hasGrapple() == 1 and (hasIce() == 1 or hasSpringBall() == 1) then
        return 1
    end
    return 0
end

function canGetHigh()
    if hasHiJump() == 1 then
        return 1
    else
        return canFly()
    end
end

function canGetHighSpeed()
    if hasHiJump() == 1 then
        return 1
    else
        return canFlyStraightUp()
    end
end

function canBallJump()
    if hasMorph() == 1 and (hasSpringBall() == 1 or hasBasicBombs() == 1 or (hasPowerBombs() == 1 and countAmmo() / 20 >= 5.0)) then
        return 1
    end
    return 0
end

function canDoCrumblePassages()
    if hasMorph() == 1 and hasSpringBall() == 1 then
        return 1
    end
    return 0
end

function canDoSpeedPassages()
    if canDoCrumblePassages() == 1 and hasSpeedBooster() == 1 then
        return 1
    end
    return 0
end

function canRevealItems()
    if hasXray() == 1 or hasWave() == 1 or canPowerBomb() == 1 then
        return 1
    end
    return 0
end

function canDefeatSilverSpacePirates()
    if hasCharge() == 1 or hasMissiles() == 1 or hasSuper() == 1 then
        return 1
    end
    return 0
end


-- Access logic functions

function canAccessDeepCrateria()
    if hasGate01() == 1 or canOpenRedDoors() == 1 or hasMorph() == 1 then
        return 1
    end
    return 0
end

function canAccessBrinstar()
    if hasGate01() == 1 and canOpenRedDoors() == 1 and (hasMorph() == 1 or hasSpeedBooster() == 1) then
        return 1
    else
        return canGetHighSpeed()
    end
end

function canGetPastBrinstarEntrance()
    if hasGate01() == 1 and canOpenRedDoors() == 1 and (hasMorph() == 1 or (canBombPassages() == 1 or hasSpeedBooster() == 1)) then
        return 1
    elseif hasBeatenSporeSpawn() == 1 and (canOpenRedDoors() == 1 or canFlyStraightUp() == 1) then
        return 1
    end
    return 0
end

function canAccessNorfair()
    if canAccessNorfairMain() == 1 or canAccessNorfairB() == 1 or canAccessNorfairC() == 1 or canAccessNorfairM() == 1 then
        return canHellRun()
    end
    return 0
end

--Main Crateria Entrance
function canAccessNorfairMain()
    if hasGate01() == 1 and canOpenRedDoors() == 1 then
        return 1
    end
    return 0
end

--Brinstar Entrance
function canAccessNorfairB()
    if canAccessBrinstar() == 1 and canGetPastBrinstarEntrance() == 1 and (hasBeatenSporeSpawn() == 1 or (hasMorph() == 1 and canOpenGreenDoors() == 1)) then
        return 1
    end
    return 0
end

--Alt Crateria Entrance
function canAccessNorfairC()
    if hasMorph() == 1 and canOpenGreenDoors() == 1 then
        return 1
    end
    return 0
end

--Maridia Entrance
function canAccessNorfairM()
    if canPowerBomb() == 1 and canOpenGreenDoors() == 1 and hasGravity() == 1 then
        return 1
    end
    return 0
end

function canAccessDeepNorfair()
    if heatProof() == 1 and (canBombWalls() == 1 or (hasSpeedBooster() == 1 and canPowerBomb() == 1)) then
        if hasMorph() == 1 and canAccessNorfairB() == 1 then
            return 1
        elseif hasMorph() == 1 and canOpenGreenDoors() == 1 and
                ((canAccessNorfairM() == 1 and canBombPassages() == 1) or canAccessNorfairC() == 1 or canAccessNorfairMain() == 1) then
            if hasGrapple() == 1 then
                return 1
            else
                return canFlyStraightUp()
            end
        elseif hasBeatenCrocomire() == 1 and canBombWalls() == 1 then
            return canFlyStraightUp()
        end
    end
    return 0
end

function canAccessWreckedShip()
    if hasMorph() == 1 and hasGate01() == 1 then
        if hasGravity() == 1 then
            return 1
        end
        return canGetHighSpeed()
    end
    return 0
end

function canAccessDeepWreckedShip()
    if (canOpenGreenDoors() == 1 and canBallJump() == 1) or hasBeatenPhantoon() == 1 then
        return 1
    end
    return 0
end

function canAccessMaridia()
    if canAccessMaridiaMain() == 1 or canAccessMaridiaW() == 1 or canPowerBomb() == 1 then
        if hasGravity() == 1 then
            return 1
        else
            return 1, AccessibilityLevel.SequenceBreak
        end
    end
    return 0
end

--Main Crateria Entrance
function canAccessMaridiaMain()
    if canOpenRedDoors() == 1 and canDoCrumblePassages() == 1 and canBombPassages() == 1 then
        return 1
    end
    return 0
end

--Wrecked Ship Elevator Entrance
function canAccessMaridiaW()
    if canAccessDeepWreckedShip() == 1 and canOpenGreenDoors() == 1 and hasMorph() == 1 and (hasGravity() == 1 or (hasHiJump() == 1 and hasBeatenPhantoon() == 1)) then
        return 1
    end
    return 0
end

function canAccessScrewAttack()
    if hasGate01() == 1 and hasGate02() == 1 and hasGate03() == 1 and
       hasGate04() == 1 and hasGate05() == 1 and hasGate06() == 1 and
       hasGate07() == 1 and hasGate08() == 1 and hasGate09() == 1 and
       hasGate10() == 1 and hasGate11() == 1 and hasGate12() == 1 and
       hasGate13() == 1 and hasGate14() == 1 and hasGate15() == 1 then
        return 1
    end
    return 0
end
