local function SpawnGenericZombie(Amount, Health, Damage, Speed, FollowRange)
    for I = 1, Amount do
        local Command = '/summon zombie ~ ~ ~ {Health:'..Health..',Attributes:[{Name:"generic.max_health",Base:'..Health..'},{Name:"generic.attack_damage",Base:'..Damage..'},{Name:"generic.movement_speed",Base:'..Speed..'},{Name:"generic.follow_range",Base:'..FollowRange..'}]}'
        commands.exec(Command)
    end
end

local function SpawnRunnerZombie(Amount, Health, Damage, Speed, FollowRange)
    for I = 1, Amount do
        local Command = '/summon zombie ~ ~ ~ {Health:'..Health..',Attributes:[{Name:"generic.max_health",Base:'..Health..'},{Name:"generic.attack_damage",Base:'..Damage..'},{Name:"generic.movement_speed",Base:'..Speed..'},{Name:"generic.follow_range",Base:'..FollowRange..'}]}'
        commands.exec(Command)
    end
end

local function SpawnBruteZombie(Amount, Health, Damage, Speed, FollowRange)
    for I = 1, Amount do
        local Command = '/summon zombie ~ ~ ~ {Health:'..Health..',Attributes:[{Name:"generic.max_health",Base:'..Health..'},{Name:"generic.attack_damage",Base:'..Damage..'},{Name:"generic.movement_speed",Base:'..Speed..'},{Name:"generic.follow_range",Base:'..FollowRange..'}],ArmorItems:[{id:"marbledsarsenal:black_juggernaut_armor_boots",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_leggins",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_chestplate",Count:1},{id:"marbledsarsenal:black_juggernaut_armor_helmet",Count:1}]}'
        commands.exec(Command)
    end
end

sleep(1)

SpawnGenericZombie(1, 20, 3, 0.3, 99)
SpawnRunnerZombie(1, 5, 1.5, 0.4, 12)
SpawnBruteZombie(1, 40, 6, 0.25, 99)





