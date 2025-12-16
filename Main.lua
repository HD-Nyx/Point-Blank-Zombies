local StarterGun = "pointblank:m1911a1"
local StarterAmmo = "pointblank:ammo45acp"
local StarterAmmoAmount = 28
local StarterMelee = "minecraft:wooden_sword{Unbreakable:1b}"

commands.exec('/gamemode adventure @a')
commands.exec('/clear @a')
commands.exec('/team join Survivors @a')
commands.exec('/scoreboard players set @a Points 0')
commands.exec('/scoreboard players set #zombies ZombiesAlive 0')
commands.exec('/give @a ' .. StarterGun)
commands.exec('/give @a ' .. StarterAmmo .. ' ' .. StarterAmmoAmount)
commands.exec('/give @a ' .. StarterMelee)

local Wave = 0
local WaveInProgress = false
local BaseHealth = {Generic = 20, Runner = 5, Brute = 40}
local BaseDamage = {Generic = 3, Runner = 1.5, Brute = 6}
local BaseSpeed = {Generic = 0.3, Runner = 0.4, Brute = 0.25}
local BaseFollowRange = {Generic = 99, Runner = 12, Brute = 99}

math.randomseed(os.time())
math.random()


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

--LETS GO GAMBLING!!
local function SpawnRandomZombie(HealthMultiplier, RunnerChance, BruteChance)
    local Roll = math.random()

    if Roll < BruteChance then

        SpawnBruteZombie(
            1,
            BaseHealth.Brute * HealthMultiplier,
            BaseDamage.Brute,
            BaseSpeed.Brute,
            BaseFollowRange.Brute
        )
    elseif Roll < BruteChance + RunnerChance then

        SpawnRunnerZombie(
            1,
            BaseHealth.Runner * HealthMultiplier,
            BaseDamage.Runner,
            BaseSpeed.Runner,
            BaseFollowRange.Runner
        )
    else
        --aw dang it :(
        SpawnGenericZombie(
            1,
            BaseHealth.Generic * HealthMultiplier,
            BaseDamage.Generic,
            BaseSpeed.Generic,
            BaseFollowRange.Generic
        )
    end
end



local function SpawnNewWave()
    WaveInProgress = true
    Wave = Wave + 1

    local HealthMultiplier = 1 + (Wave - 1) * 0.1
    local AmountOfZombies = (Wave + 1) * 8

    local RunnerChance = math.min(0.2, Wave * 0.02)
    local BruteChance  = math.min(0.2, Wave * 0.015)

    commands.exec('/tellraw @a {"text":"Wave '..Wave..'","color":"red","bold":true}')
    commands.exec('/scoreboard players set #zombies ZombiesAlive 0')

    for i = 1, AmountOfZombies do
        SpawnRandomZombie(HealthMultiplier, RunnerChance, BruteChance)
        commands.exec('/scoreboard players add #zombies ZombiesAlive 1')
        sleep(3 + math.random(1, 3))
    end
end

SpawnNewWave()
