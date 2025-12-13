--Simple template for buyng weapons/guns
--Only setup you need to do is replace Item, Ammo, AmmoAmount and Price to your likeing

local Item = "pointblank:ak74"
local Ammo = "pointblank:ammo545"
local AmmoAmount = 180
local Price = 100

while true do
    os.pullEvent("redstone")  
    if redstone.getInput("front") then

        local PointsSuccess, PointsData = commands.exec('/scoreboard players get @p Points')
        local PointsText = PointsData[1]
        local PointsAmount = tonumber(PointsText:match("(%d+)"))
        
        if PointsAmount >= Price then
             local ItemSuccess, ItemData = commands.exec("clear @p " .. Item .. " 0")
             local ItemCount = tonumber(ItemData[1]:match("(%d+)")) or 0

             if ItemCount >= 1 then
                commands.exec('/give @p ' .. Ammo .. ' ' .. AmmoAmount)
                commands.exec("/scoreboard players remove @p Points " .. Price)
                commands.exec("/msg @p Purchased: " .. Ammo)
                commands.exec('/playsound minecraft:entity.player.levelup master @p ~ ~ ~ 1 0.75')
             else
                commands.exec('/give @p ' .. Item)
                commands.exec('/give @p ' .. Ammo .. ' ' .. AmmoAmount)
                commands.exec("/scoreboard players remove @p Points " .. Price)
                commands.exec("/msg @p Purchase was successful")
                commands.exec('/playsound minecraft:entity.player.levelup master @p ~ ~ ~ 1 0.75')
            end

        else
            commands.exec("/msg @p You don't have enough points peasant")
            commands.exec('/playsound minecraft:block.note_block.bass master @p ~ ~ ~ 1 0.5')
        end

    end
end