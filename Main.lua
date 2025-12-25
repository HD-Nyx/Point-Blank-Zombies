local StarterGun = "pointblank:m1911a1"
local StarterAmmo = "pointblank:ammo45acp"
local StarterAmmoAmount = 28
local StarterMelee = "minecraft:wooden_sword{Unbreakable:1b}"

commands.exec('/gamemode adventure @a')
commands.exec('/gamerule sendCommandFeedback false')
commands.exec('/execute at @e[type=minecraft:armor_stand,tag=PlayerSpawner,limit=1] run tp @a ~ ~ ~')
commands.exec('/clear @a')
commands.exec('/team join Survivors @a')
commands.exec('/scoreboard players set @a Points 0')
commands.exec('/give @a ' .. StarterGun)
commands.exec('/give @a ' .. StarterAmmo .. ' ' .. StarterAmmoAmount)
commands.exec('/give @a ' .. StarterMelee)

local Wave = 0
local WaveInProgress = false
local AmountOfZombies = 0

local BaseHealth = {Generic = 20, Runner = 5, Brute = 40}
local BaseDamage = {Generic = 3, Runner = 1.5, Brute = 6}
local BaseSpeed = {Generic = 0.3, Runner = 0.4, Brute = 0.25}
local BaseFollowRange = {Generic = 99, Runner = 12, Brute = 99}

local RandomTips = {
    'Good luck...',
    'They are coming.',
    'Do not be scared..',
    'There is no hope.',
    'Monkey see, monkey do',
    'SURVIVE',
    'Try not to corner yourself..',
    'They will slow you down then eat your internal organs',
    'They will sniff you and track you down...',
    '-... .-. --- / .. -- .- --. .. -. . / .-- .- ... - .. -. --. / -.-- --- ..- .-. / - .. -- . / - --- / - .-. .- -. ... .-.. .- - . / - .... .. ... / .-.. --- .-..'
}

local function SpawnGenericZombie(Health, Damage, Speed, FollowRange) 
    commands.exec('/execute at @e[type=armor_stand,tag=ZombieSpawner,limit=1,sort=random] run summon minecraft:zombie ~ ~1 ~ {Tags:["Zombie"],Health:'..Health..'f,Attributes:[{Name:"generic.max_health",Base:'..Health..'f},{Name:"generic.attack_damage",Base:'..Damage..'f},{Name:"generic.movement_speed",Base:'..Speed..'f},{Name:"generic.follow_range",Base:'..FollowRange..'f}]}')
end


local function SpawnRunnerZombie(Health, Damage, Speed, FollowRange) 
    commands.exec('/execute at @e[type=armor_stand,tag=ZombieSpawner,limit=1,sort=random] run summon minecraft:zombie ~ ~1 ~ {Tags:["Zombie","Runner"],Health:'..Health..'f,Attributes:[{Name:"generic.max_health",Base:'..Health..'f},{Name:"generic.attack_damage",Base:'..Damage..'f},{Name:"generic.movement_speed",Base:'..Speed..'f},{Name:"generic.follow_range",Base:'..FollowRange..'f}]}')
end


local function SpawnBruteZombie(Health, Damage, Speed, FollowRange) 
    commands.exec('/execute at @e[type=armor_stand,tag=ZombieSpawner,limit=1,sort=random] run summon minecraft:zombie ~ ~1 ~ {Tags:["Zombie","Brute"],Health:'..Health..'f,Attributes:[{Name:"generic.max_health",Base:'..Health..'f},{Name:"generic.attack_damage",Base:'..Damage..'f},{Name:"generic.movement_speed",Base:'..Speed..'f},{Name:"generic.follow_range",Base:'..FollowRange..'f}],ArmorItems:[{id:"marbledsarsenal:black_juggernaut_armor_boots",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_leggins",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_chestplate",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_helmet",Count:1}]}')
end


local function SpawnRandomZombie(HealthMultiplier, RunnerChance, BruteChance)
    local Roll = math.random()

    if Roll < BruteChance then
        SpawnBruteZombie(
            BaseHealth.Brute * HealthMultiplier,
            BaseDamage.Brute,
            BaseSpeed.Brute,    
            BaseFollowRange.Brute
        )
    elseif Roll < BruteChance + RunnerChance then
        SpawnRunnerZombie(
            BaseHealth.Runner * HealthMultiplier,
            BaseDamage.Runner,
            BaseSpeed.Runner,
            BaseFollowRange.Runner
        )
    else
        SpawnGenericZombie(
            BaseHealth.Generic * HealthMultiplier,
            BaseDamage.Generic,
            BaseSpeed.Generic,
            BaseFollowRange.Generic
        )
    end
end

local function SpawnNewWave()
    sleep(0.1)
    WaveInProgress = true
    commands.exec('/execute at @e[type=minecraft:armor_stand,tag=PlayerSpawner,limit=1] run tp @a[gamemode=spectator] ~ ~ ~')
    commands.exec('/gamemode adventure @a[gamemode=spectator]')
    commands.exec('/stopsound @a master minecraft:pointblankzombies.ambiance1')
    commands.exec('/playsound minecraft:pointblankzombies.roundstart master @a')
    commands.exec('/tellraw @a {"text":"Wave '..Wave..' Has Been Completed!","color":"white","bold":true}')
    commands.exec('/effect give @a minecraft:saturation 10 50 false')
    commands.exec('/effect give @a minecraft:resistance 1 100 true')
    commands.exec('/effect give @a minecraft:darkness 2 0 true')
    commands.exec('/execute at @a run summon minecraft:lightning_bolt ~ ~ ~')
    commands.exec('/kill @e[type=minecraft:zombie]')

    sleep(12)
    Wave = Wave + 1

    local HealthMultiplier = 1 + (Wave - 1) * 0.1
    AmountOfZombies = (Wave + 1) * 4

    local RunnerChance = math.min(0.2, Wave * 0.02)
    local BruteChance  = math.min(0.2, Wave * 0.015)

    local RandomTip = RandomTips[math.random(#RandomTips)]

    commands.exec('/tellraw @a {"text":"Wave '..Wave..'","color":"red","bold":true}')
    commands.exec('/tellraw @a {"text":"'..RandomTip..'","color":"dark_red","bold":true,"italic":true}')
    commands.exec('/playsound minecraft:pointblankzombies.ambiance1 master @a ~ ~ ~ 0.5 1')

    for i = 1, AmountOfZombies do
        SpawnRandomZombie(HealthMultiplier, RunnerChance, BruteChance)
        sleep(math.max(0.5, 3 - Wave * 0.05) + math.random() * 0.5)
    end
end

local function AllZombiesDead()
    while true do
        sleep(0.1)
        local ZombiesThere = commands.exec('/execute if entity @e[type=minecraft:zombie, tag=Zombie]')
        if not ZombiesThere then
            SpawnNewWave()
        end
    end
end

local function AllPlayersDead()
    while true do
        sleep(0.1)
        local PlayersThere = commands.exec('/execute if entity @a[gamemode=adventure]')
        if not PlayersThere then
            WaveInProgress = false
            commands.exec('/title @a clear')
            commands.exec('/title @a title {"text":"Warning","color":"yellow","bold":false}')
            commands.exec('/title @a subtitle {"text":"The Zombies have Won","color":"dark_red","bold":true}')
            commands.exec('/weather thunder')
            commands.exec('/playsound minecraft:pointblankzombies.gameover master @a')
            sleep(9)
            commands.exec('/effect give @a minecraft:darkness 10 255 true')
            commands.exec('/title @a title "Survived ' .. Wave ..' Waves"')
            commands.exec('/execute at @e[type=minecraft:zombie] run summon minecraft:lightning_bolt ~ ~ ~')
            commands.exec('/kill @e[type=minecraft:zombie]')
            sleep(11)
            commands.exec('/stopsound @a')
            commands.exec('/gamerule sendCommandFeedback true')
            os.shutdown()
        end
    end
end

local function HowMannyZombies()
    while WaveInProgress == true do
        sleep(1)
        commands.exec('/title @a actionbar {"text":"'.. AmountOfZombies ..' Zombies Left","color":"yellow","bold":false}')
    end
end

parallel.waitForAll(AllZombiesDead, AllPlayersDead, HowMannyZombies)