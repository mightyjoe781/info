---------------ANNOUNCEMENT---------------

dofile(minetest.get_modpath("info").."/api.lua")
-- local storage = minetest.get_mod_storage()

local function send_info(name) minetest.chat_send_player(name,minetest.colorize("#ff3300"),info.display_banner())
    for element in info.info_iter() do
        if element ~= "" then
            minetest.chat_send_player(name, minetest.colorize("33ff33"), "*"..element)
        end
    end
end

local function validate_args(i)
    if i < 0 or i > 6 then
        return false, "Constraints : 0 < idx < 6"
    end
    return true, "Changes saved."
end

local function handle_chatcommand(name, param)
    local msg = param:sub(13)
    local param = param:split(" ")
    if #param == 0 then
        send_info(name)
    elseif #param >= 2 then
        -- unpack assumes 1 indexing
        local cmd, i = param[1], param[2]
        validate_args(i)
        if cmd == "set" then
            return info.set_info(i, msg)
        elseif cmd == "rem" then
            return info.rem_info(i)
        else
            return false, "Invalid options. (see /help info)"
        end
    else
        return false, "Invalid options. (see /help info)"
    end
end

minetest.register_chatcommand("info", {
	description = "[set | rem] [number] [msg]",
	paramas = "[set | rem] [number] [msg]",
    privs = {ban=true},
	func = handle_chatcommand,
})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name();
	minetest.after(10,send_info(name), name);
end)
