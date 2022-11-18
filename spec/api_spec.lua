require 'busted.runner'()
require("api")
-- require("init")

_G.minetest = {}
-- define mocks
local chat_send_calls = {}

function minetest.chat_send_player(name, player)
    table.insert(chat_send_calls, {name = name, player = player})
end

function minetest.register_chatcommand(cmd, params)
end

before_each(function()
    info.ANNOUNCEMENTS = {}
    info.CNT = 0
end)

describe("set_info_size", function()
    -- tests come here
    it("set_info_size", function()
        info.set_info(1,"Announcement-1")
        assert.equals(1, info.CNT)
    end)

    it("set_info_size", function()
        info.set_info(1,"Announcement-1")
        assert.equals(1, info.CNT)

        info.set_info(1,"Announcement-1")
        assert.equals(1, info.CNT)
    end)
end)

describe("rem_info_size", function()

    it("rem_info_size", function()
        info.rem_info(1)
        assert.equals(0, info.CNT)
    end)

    it("rem_info_size", function()
        assert.equals(0, info.CNT)
        info.set_info(1,"Announcement-1")
        assert.equals(1, info.CNT)
        info.rem_info(1)
        assert.equals(0, info.CNT)
    end)

end)

describe("get_info_test", function()
    it("get_info_get_nil", function()
        assert.falsy(info.get_info(1))
    end)
    it("get_info_gets_value", function()
        info.set_info(1,"Announcement-1")
        assert.truthy(info.get_info(1))
    end)
    it("get_info_gets_nil", function()
        info.set_info(1,"Announcement-1")
        info.rem_info(1)
        assert.falsy(info.get_info(1))
    end)
end)

describe("idx_info_check", function()

    it("rem_info_size", function()
        assert.truthy(info.idx_check(5))
        assert.truthy(info.idx_check(0))
        assert.truthy(info.idx_check(10))
        assert.falsy(info.idx_check(nil))
        assert.falsy(info.idx_check(-1))
        assert.falsy(info.idx_check(12))
    end)

end)

describe("banner_test", function()
    it("banner_test", function()
        assert.truthy(info.display_banner())
    end)
end)

describe("info_iter_test", function()
    it("simple_test", function()
        info.set_info(1,"Announcement-1")
        info.set_info(2,"Announcement-2")
        info.set_info(3,"Announcement-3")
        local out = {}
        for x in info.info_iter() do
            out[#out+1] = x
        end
        assert.equals(3,info.CNT)
        assert.equals(3,#out)
    end)

    it("simple_skip_test", function()
        info.set_info(1,"Announcement-1")
        info.set_info(4,"Announcement-4")
        info.set_info(5,"Announcement-5")
        local out = {}
        for x in info.info_iter() do
            out[#out+1] = x
        end
        assert.equals(3,info.CNT)
        assert.equals(3,#out)
    end)
    it("simple_skip_test_del_and_additions", function()
        info.set_info(1,"Announcement-1")
        info.set_info(4,"Announcement-4")
        info.rem_info(3)
        info.rem_info(3)
        info.set_info(5,"Announcement-5")
        info.rem_info(2)
        info.rem_info(5)
        local out = {}
        for x in info.info_iter() do
            out[#out+1] = x
        end
        assert.equals(2,info.CNT)
        assert.equals(2,#out)
    end)
end)
