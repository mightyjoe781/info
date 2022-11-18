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
    ANNOUNCEMENTS = {},
    CNT = 0,
    MAX_SZ = 10
}

function info.get_info(i)
    return info.ANNOUNCEMENTS[i]
end

function info.idx_check(i)
    i = tonumber(i)
    if i == nil or i < 0 or i > info.MAX_SZ then
        return false
    end
    return true
end

function info.set_info(i, msg)
    if info.idx_check(i) then
        if info.ANNOUNCEMENTS[i] == nil then
            info.CNT = info.CNT + 1
        end
        info.ANNOUNCEMENTS[i] = msg
    end
end

function info.rem_info(i)
    if info.idx_check(i) then
        if info.ANNOUNCEMENTS[i] ~= nil then
            info.CNT = info.CNT - 1
        end
        info.ANNOUNCEMENTS[i] = nil
    end
end

function info.display_banner()
    return "--------------- ANNOUNCEMENTS ---------------"
end

function info.info_iter()
    local i = 0
    local n = info.MAX_SZ
    return function ()
        i = i + 1
        while info.ANNOUNCEMENTS[i] == nil and i <= n do
            i = i + 1
        end
        if i <= n then
            return info.ANNOUNCEMENTS[i]
        end
    end
end
