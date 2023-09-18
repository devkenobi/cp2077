
uma = {
    description = "Detects and unlocks achievements earned based on the current save game data",
    modName = "Unlock Missed Achievements",
    modVer = "v1.0.0",
    moduleVer = "v1.0.0",
    uiVisible = false
}

local achievements = {
    { fact = "q000_done", threshold = 1, id = "TheFool", desc = "The Fool" },
    { fact = "q005_done", threshold = 1, id = "TheLovers", desc = "The Lovers" },
    { fact = "q104_done", threshold = 1, id = "TheWheelOfFortune", desc = "The Wheel of Fortune" },
    { fact = "q110_done", threshold = 1, id = "TheHermit", desc = "The Hermit" },
    { fact = "q112_done", threshold = 1, id = "TheHightPriestess", desc = "The High Priestess" },
    { fact = "q201_done", threshold = 1, id = "TheWorld", desc = "The World" },
    { fact = "sq027_done", threshold = 1, id = "QueenOfTheHighway", desc = "Life of the Road" },
    { fact = "sq028_done", threshold = 1, id = "BornToBeWild", desc = "To Bad Decisions!" },
    { fact = "sq029_done", threshold = 1, id = "FollowingTheRiver", desc = "To Protect and Serve" },
    { fact = "sq030_done", threshold = 1, id = "UnderPressure", desc = "Judy vs Night City" },
    { fact = "sq031_done", threshold = 1, id = "BushidoAndChill", desc = "Bushido and Chill" },
    { fact = "mq033_grafitti_counter", threshold = 20, id = "Fortuneteller", desc = "The Wandering Fool" },
    { fact = "ow_psychos_reward_collected", threshold = 1, id = "IAmMaxTac", desc = "I am The Law"}
}

function checkAchievements()
    for i,a in ipairs(achievements) do
        print("\"" .. a.desc .. "\" earned? " .. tostring(isDeserved(a)))
    end
end

function unlockAchievements()
    for i,a in ipairs(achievements) do
        if isDeserved(a) then
            Game.UnlockAchievementEnum(a.id)
            print("Triggered unlock event for [" .. a.desc .."]")
        end
    end
end

function isDeserved(achievement)
    return Game.GetQuestsSystem():GetFactStr(achievement.fact) >= achievement.threshold
end

function drawUI()
    if (ImGui.Begin(uma.modName, ImGuiWindowFlags.AlwaysAutoResize)) then
        if (ImGui.Button("Check Achievements (console)", 300, 28)) then
            checkAchievements()
        end

        if (ImGui.Button("Unlock Earned Achievements", 300, 28)) then
            unlockAchievements()
        end
    end
    ImGui.End()
end

registerForEvent("onInit", function()
    uma.uiVisible = false
end)
  
registerForEvent("onOverlayOpen", function()
    uma.uiVisible = true
end)
  
registerForEvent("onOverlayClose", function()
    uma.uiVisible = false
end)

registerForEvent("onDraw", function()
    if uma.uiVisible then
        drawUI()
    end
end)
