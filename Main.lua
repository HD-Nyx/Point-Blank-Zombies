local StarterGun = "pointblank:m1911a1"
local StarterAmmo = "pointblank:ammo45acp"
local StarterAmmoAmount = 28
local StarterMelee = "minecraft:wooden_sword{Unbreakable:1b}"

commands.exec('/gamemode adventure @a')
commands.exec('/clear @a')
commands.exec('/scoreboard players set @a Points 0')
commands.exec('/give @a ' .. StarterGun)
commands.exec('/give @a ' .. StarterAmmo .. ' ' .. StarterAmmoAmount)
commands.exec('/give @a ' .. StarterMelee)

local Wave = 0
local BaseHealth = {Generic = 20, Runner = 5, Brute = 40}
local BaseDamage = {Generic = 3, Runner = 1.5, Brute = 6}
local BaseSpeed = {Generic = 0.3, Runner = 0.4, Brute = 0.25}
local BaseFollowRange = {Generic = 99, Runner = 12, Brute = 99}

local function SpawnGenericZombie(Amount, Health, Damage, Speed, FollowRange)
    for I = 1, Amount do
        local Command = '/summon zombie ~ ~ ~ {Health:'..Health..'f,Attributes:[{Name:"generic.max_health",Base:'..Health..'f},{Name:"generic.attack_damage",Base:'..Damage..'f},{Name:"generic.movement_speed",Base:'..Speed..'f},{Name:"generic.follow_range",Base:'..FollowRange..'f}]}'
        commands.exec(Command)
    end
end

local function SpawnRunnerZombie(Amount, Health, Damage, Speed, FollowRange)
    for I = 1, Amount do
        local Command = '/summon zombie ~ ~ ~ {Health:'..Health..'f,Attributes:[{Name:"generic.max_health",Base:'..Health..'f},{Name:"generic.attack_damage",Base:'..Damage..'f},{Name:"generic.movement_speed",Base:'..Speed..'f},{Name:"generic.follow_range",Base:'..FollowRange..'f}]}'
        commands.exec(Command)
    end
end

local function SpawnBruteZombie(Amount, Health, Damage, Speed, FollowRange)
    for I = 1, Amount do
        local Command = '/summon zombie ~ ~ ~ {Health:'..Health..'f,Attributes:[{Name:"generic.max_health",Base:'..Health..'f},{Name:"generic.attack_damage",Base:'..Damage..'f},{Name:"generic.movement_speed",Base:'..Speed..'f},{Name:"generic.follow_range",Base:'..FollowRange..'f}],ArmorItems:[{id:"marbledsarsenal:black_juggernaut_armor_boots",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_leggins",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_chestplate",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_helmet",Count:1}]}'
        commands.exec(Command)
    end
end


local function SpawnNewWave()
    local HealthMultiplier = 1 + (Wave - 1) * 0.1
    local AmountMultiplier = (Wave + 1) * 8
end