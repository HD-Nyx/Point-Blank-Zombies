local CountDownAmount = 20

commands.exec('/gamerule sendCommandFeedback false')
commands.exec('/tp @a @e[tag=LobbySpawn,limit=1]')
commands.exec('/gamemode adventure @a')
commands.exec('/team join Survivors @a')
commands.exec('/weather clear')

for Time = CountDownAmount, 1, -1 do
    commands.exec('/title @a actionbar {"text":"Game is starting in ' .. Time .. ' seconds","color":"dark_red","bold":true}')
    if Time == CountDownAmount or Time <= 10 then
        commands.exec("/playsound minecraft:block.note_block.hat master @a ~ ~ ~ 1 1")
    end
    sleep(1)
end

commands.exec("/playsound minecraft:block.note_block.pling master @a ~ ~ ~ 1 1")
commands.exec('/scoreboard players set #zombies StartGame 1')

sleep(5)

if commands.exec('/execute as @e[tag=LobbySpawn] at @s if entity @a[distance=..16]') then
    commands.exec('/msg @a If you are still not teleporting then the computer is not loaded, go to the map, look for a computer next to command blocks and right click it, it should be working now, sorry.')
end