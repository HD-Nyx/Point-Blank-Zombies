                                                                                                                                                                                                                                                                        
--     _____           _____     ____  _____   ______   _________________             _____    ____               ____  _____   ______    ____    ____           _____                 _____         ______  _______         _____    ____      ______            ______  
-- ___|\    \     ____|\    \   |    ||\    \ |\     \ /                 \       ___|\     \  |    |         ____|\   \|\    \ |\     \  |    |  |    |         /    /|___        ____|\    \       |      \/       \   ___|\     \  |    | ___|\     \       ___|\     \ 
--|    |\    \   /     /\    \  |    | \\    \| \     \\______     ______/      |    |\     \ |    |        /    /\    \\\    \| \     \ |    |  |    |        /    /|    |      /     /\    \     /          /\     \ |    |\     \ |    ||     \     \     |    |\     \
--|    | |    | /     /  \    \ |    |  \|    \  \     |  \( /    /  )/         |    | |     ||    |       |    |  |    |\|    \  \     ||    | /    //       |\____\|    |     /     /  \    \   /     /\   / /\     ||    | |     ||    ||     ,_____/|    |    |/____/|
--|    |/____/||     |    |    ||    |   |     \  |    |   ' |   |   '          |    | /_ _ / |    |  ____ |    |__|    | |     \  |    ||    |/ _ _//        | |   |/    |___ |     |    |    | /     /\ \_/ / /    /||    | /_ _ / |    ||     \--'\_|/ ___|    \|   | |
--|    ||    |||     |    |    ||    |   |      \ |    |     |   |              |    |\    \  |    | |    ||    .--.    | |      \ |    ||    |\    \'         \|___/    /    ||     |    |    ||     |  \|_|/ /    / ||    |\    \  |    ||     /___/|  |    \    \___|/ 
--|    ||____|/|\     \  /    /||    |   |    |\ \|    |    /   //              |    | |    | |    | |    ||    |  |    | |    |\ \|    ||    | \    \            /     /|    ||\     \  /    /||     |       |    |  ||    | |    | |    ||     \____|\ |    |\     \    
--|____|       | \_____\/____/ ||____|   |____||\_____/|   /___//               |____|/____/| |____|/____/||____|  |____| |____||\_____/||____|  \____\          |_____|/____/|| \_____\/____/ ||\____\       |____|  /|____|/____/| |____||____ '     /||\ ___\|_____|   
--|    |        \ |    ||    | /|    |   |    |/ \|   ||  |`   |                |    /     || |    |     |||    |  |    | |    |/ \|   |||    |   |    |         |     |    | | \ |    ||    | /| |    |      |    | / |    /     || |    ||    /_____/ || |    |     |   
--|____|         \|____||____|/ |____|   |____|   |___|/  |____|                |____|_____|/ |____|_____|/|____|  |____| |____|   |___|/|____|   |____|         |_____|____|/   \|____||____|/  \|____|      |____|/  |____|_____|/ |____||____|     | / \|____|_____|   
--  \(              \(    )/      \(       \(       )/      \(                    \(    )/      \(    )/     \(      )/     \(       )/    \(       )/             \(    )/         \(    )/        \(          )/       \(    )/      \(    \( |_____|/     \(    )/     
--   '               '    '        '        '       '        '                     '    '        '    '       '      '       '       '      '       '               '    '           '    '          '          '         '    '        '     '    )/         '    '      
                                                                                                                                                                                                                                                                       
--Zombies mod for Point Blank: Zombies using CC:TWEAKED
--Made by HD_Nyx
--Doccmention used: https://tweaked.cc/ , https://minecraft.wiki/w/Zombie


--Use these commands to set up variables that are going to be used
--Only needs to run once 
--After thee commmands, it won't display anything until a player gets a point, then it should show up
--If it still doesnt work after that then try manually enter the commands

commands.exec('/scoreboard objectives add Points dummy "Points"')
commands.exec('/scoreboard objectives setdisplay sidebar Points')

commands.exec('/scoreboard objectives add ZombiesAlive dummy')

commands.exec('/team add Survivors')
commands.exec('/team modify Survivors friendlyFire false')

commands.exec('/gamerule doFireTick false')

--Place these command blocks and put the command and its propertys

--Repeating, Unconditional, Always Active
--/execute as @a[scores={KilledZombie=1..}] at @s run scoreboard players add @s Points 100

--Chain, Unconditional, Always Active
--/execute if entity @a[scores={KilledZombie=1..}] run scoreboard players remove #zombie ZombiesAlive 1

--Chain, Unconditional, Always Active
--/scoreboard players reset @a[scores={KilledZombie=1..}] KilledZombie

