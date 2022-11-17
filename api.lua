--[[
* --------------------------------------------------------------------
* @file    api.lua
* @brief   API for info mod
* @author  smk (sudhanshumohan781@gmail.com)
* @version 20221116
* @license BSD3
* @bugs    No known bugs
* --------------------------------------------------------------------
]]

info = {
    ANNOUNCEMENTS = {}
}

function info.get_info(i)
    if info.ANNOUNCEMENTS[i] ~= "" then
        return info.ANNOUNCEMENTS[i]
    end
end

function info.set_info(i, msg)
    i = tonumber(i)
    if i == nil then return end
    if msg ~= nil then
        info.ANNOUNCEMENTS[i] = msg
    end
    info.ANNOUNCEMENTS[i] = ""
end

function info.del_info(i)
    info.ANNOUNCEMENTS[i] = ""
end

function info.display_banner()
    return "--------------- ANNOUNCEMENTS ---------------"
end

function info.info_iter()
    local i = 0
    local n = #info.ANNOUNCEMENTS
    return function ()
        i = i + 1
        if i <= n then return info.ANNOUNCEMENTS[i] end
    end
end
