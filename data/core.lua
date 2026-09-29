--=====================================================================================
-- FFLU | Final Fantasy Level-Up! - core.lua
-- Version: 3.0.0
-- Author: DonnieDice
-- Description: Professional World of Warcraft addon that plays Final Fantasy level-up sound
-- RGX Mods Collection - RealmGX Community Project
--=====================================================================================

local RGX = assert(_G.RGXFramework, "FFLU: RGX-Framework not loaded")

FFLU = FFLU or {}

local ADDON_VERSION = "3.0.5"
local ADDON_NAME = "FinalFantasyLevelUp"
local PREFIX = "|Tinterface/addons/FinalFantasyLevelUp/media/icon:16:16|t - |cffffffff[|r|cffffe568FFLU|r|cffffffff]|r "
local TITLE = "|Tinterface/addons/FinalFantasyLevelUp/media/icon:18:18|t [|cffffe568F|r|cffffffffinal|r |cffffe568F|r|cffffffffantasy|r |cffffe568L|r|cffffffffevel|r |cffffe568U|r|cffffffffp!|r]"

FFLU.version = ADDON_VERSION
FFLU.addonName = ADDON_NAME

local Sound = RGX:GetSound()

local handle = Sound:Register(ADDON_NAME, {
    sounds = {
        high   = "Interface\\Addons\\FFLU\\sounds\\final_fantasy_high.ogg",
        medium = "Interface\\Addons\\FFLU\\sounds\\final_fantasy_med.ogg",
        low    = "Interface\\Addons\\FFLU\\sounds\\final_fantasy_low.ogg",
    },
    defaultSoundId = 569593,
    savedVar       = "FFLUSettings",
    defaults       = {
        enabled      = true,
        soundVariant = "medium",
        muteDefault  = true,
        showWelcome  = true,
        volume       = "Master",
        firstRun     = true,
    },
    triggerEvent   = "PLAYER_LEVEL_UP",
    addonVersion   = ADDON_VERSION,
})

FFLU.handle = handle

local L = FFLU.L or {}

local initialized = false

local function ShowHelp()
    print(PREFIX .. " " .. (L["HELP_HEADER"] or ""))
    print(PREFIX .. " " .. (L["HELP_TEST"] or ""))
    print(PREFIX .. " " .. (L["HELP_ENABLE"] or ""))
    print(PREFIX .. " " .. (L["HELP_DISABLE"] or ""))
    print(PREFIX .. " " .. (L["HELP_HIGH"] or ""))
    print(PREFIX .. " " .. (L["HELP_MED"] or ""))
    print(PREFIX .. " " .. (L["HELP_LOW"] or ""))
end

local function HandleSlashCommand(args)
    local command = string.lower(args or "")

    if command == "" or command == "help" then
        ShowHelp()
    elseif command == "test" then
        print(PREFIX .. " " .. (L["PLAYING_TEST"] or ""))
        handle:Test()
    elseif command == "enable" then
        handle:Enable()
        print(PREFIX .. " " .. (L["ADDON_ENABLED"] or ""))
    elseif command == "disable" then
        handle:Disable()
        print(PREFIX .. " " .. (L["ADDON_DISABLED"] or ""))
    elseif command == "high" then
        handle:SetVariant("high")
        print(PREFIX .. " " .. string.format(L["SOUND_VARIANT_SET"] or "%s", "high"))
    elseif command == "med" or command == "medium" then
        handle:SetVariant("medium")
        print(PREFIX .. " " .. string.format(L["SOUND_VARIANT_SET"] or "%s", "medium"))
    elseif command == "low" then
        handle:SetVariant("low")
        print(PREFIX .. " " .. string.format(L["SOUND_VARIANT_SET"] or "%s", "low"))
    else
        print(PREFIX .. " " .. (L["ERROR_PREFIX"] or "") .. " " .. (L["ERROR_UNKNOWN_COMMAND"] or ""))
    end
end

RGX:RegisterEvent("ADDON_LOADED", function(event, addonName)
    if addonName ~= ADDON_NAME then return end
    handle:SetLocale(FFLU.L)
    L = FFLU.L or {}
    handle:Init()
    initialized = true
end, "FFLU_ADDON_LOADED")

RGX:RegisterEvent("PLAYER_LEVEL_UP", function()
    if initialized then
        handle:Play()
    end
end, "FFLU_PLAYER_LEVEL_UP")

RGX:RegisterEvent("PLAYER_LOGIN", function()
    if not initialized then
        handle:SetLocale(FFLU.L)
        L = FFLU.L or {}
        handle:Init()
        initialized = true
    end
    handle:ShowWelcome(PREFIX, TITLE)
end, "FFLU_PLAYER_LOGIN")

RGX:RegisterEvent("PLAYER_LOGOUT", function()
    handle:Logout()
end, "FFLU_PLAYER_LOGOUT")

RGX:RegisterSlashCommand("fflu", function(msg)
    local ok, err = pcall(HandleSlashCommand, msg)
    if not ok then
        print(PREFIX .. " " .. (L["ERROR_PREFIX"] or "") .. " " .. tostring(err))
    end
end, "FFLU_SLASH")
