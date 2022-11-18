require 'busted.runner'()

_G.minetest = {}
require("init")


-- define mocks
local chat_send_calls = {}

function minetest.chat_send_player(name, player)
    table.insert(chat_send_calls, {name = name, player = player})
end

before_each(function()
    info.ANNOUNCEMENTS = {}
    info.CNT = 0
end)

