--[[

                         __                __
                        /  |              /  |
    ______   __    __  _$$ |_     ______  $$ |        ______    ______    ______   _______
   /      \ /  |  /  |/ $$   |   /      \ $$ |       /      \  /      \  /      \ /       \
   $$$$$$  |$$ |  $$ |$$$$$$/   /$$$$$$  |$$ |      /$$$$$$  | $$$$$$  |/$$$$$$  |$$$$$$$  |
   /    $$ |$$ |  $$ |  $$ | __ $$ |  $$ |$$ |      $$    $$ | /    $$ |$$ |  $$/ $$ |  $$ |
  /$$$$$$$ |$$ \__$$ |  $$ |/  |$$ \__$$ |$$ |_____ $$$$$$$$/ /$$$$$$$ |$$ |      $$ |  $$ |
  $$    $$ |$$    $$/   $$  $$/ $$    $$/ $$       |$$       |$$    $$ |$$ |      $$ |  $$ |
   $$$$$$$/  $$$$$$/     $$$$/   $$$$$$/  $$$$$$$$/  $$$$$$$/  $$$$$$$/ $$/       $$/   $$/


  @Original_Author : Open-Wow

  This script allow player to learn spells on levelUp.

  @Open-Wow Github : https://github.com/Open-Wow
  @Open-Wow Site : https://open-wow.fr

  @AzerothCore Community : https://discord.gg/PaqQRkd
  @Open-Wow Community : https://discord.gg/mTHxKmY

  Thanks for your patience <3.

]] --

local autoLearn = {}

autoLearn.Spell = {}

autoLearn.Class = {
    [1] = {200001, 200002},
    [2] = {200003, 200004},
    [3] = {200013, 200014},
    [4] = {200015, 200016},
    [5] = {200011, 200012},
    [6] = {200019},
    [7] = {200017, 200018},
    [8] = {200007, 200008},
    [9] = {200009, 200010},
    [11] = {200005, 200006}
}

function autoLearn.onServerStart(event)
    local getSpell =
        WorldDBQuery(
        "SELECT ID, SpellID, ReqLevel FROM `npc_trainer` WHERE `ID` > 200000 AND `ID` < 200020 AND `ReqSkillLine` = 0 ORDER BY `ID` ASC;"
    )
    repeat
        table.insert(autoLearn.Spell, {getSpell:GetUInt32(0), getSpell:GetUInt32(1), getSpell:GetUInt32(2)})
    until not getSpell:NextRow()
end
RegisterServerEvent(14, autoLearn.onServerStart)

function autoLearn.onLevelUp(event, player, oldLevel)
    local pClass = player:GetClass()

    for _, class in pairs(autoLearn.Class[pClass]) do
        for _, value in pairs(autoLearn.Spell) do
            if (value[1] == class) then
                if ((oldLevel + 1) >= value[3]) then
                    player:LearnSpell(value[2])
                end
            end
        end
    end
end
RegisterPlayerEvent(13, autoLearn.onLevelUp)
