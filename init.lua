---------------ANNOUNCEMENT---------------
info = {}

local storage = minetest.get_mod_storage()

local function get_info(name)
	-- flag used to print header only once
	local flag = false
	for i = 1,5 do
		local msg = storage:get_string(i)
		if msg ~= nil and msg ~= "" then
			if flag == false then
				minetest.chat_send_player(name,minetest.colorize("#ff3300",
					 "--------------- ANNOUNCEMENTS ---------------"))
				flag = true
			end
			minetest.chat_send_player(name, minetest.colorize("#33ff33", "*"..msg))
		end
	end
	--[[
	if flag == false then
		minetest.chat_send_player(name, "No announcements to show.")
	end
	-]]
end

local function set_info(arg1, num, msg)
	num = tonumber(num)
	if type(num) == "number" and num < 6 then
		if arg1 == "set" then
			storage:set_string(num,msg)
		elseif arg1 == "rem" then
			storage:set_string(num,nil)
		end
	else
		return false, "Invalid options, Please enter value of type number less than 6"
	end
	return true, "Changes saved."
end

minetest.register_chatcommand("info", {
	description = "[set | rem] [number] [msg]",
	paramas = "[set | rem] [number] [msg]",
	func = function(name, param)
		local param = param:split(" ")
		if #param == 0 then
			get_info(name)
		elseif #param >= 2 then
			if not minetest.check_player_privs(name,"ban") then
			return false, "Invalid priv level to update announcements."
			end
			-- attach parameters
			local msg = ""
			if param[1] == "set" then
				for i = 3, #param do
					msg = msg .. " " .. param[i]
				end
				return set_info(param[1], param[2], msg)
			elseif param[1] == "rem" then
				return set_info(param[1], param[2], msg)
			else
				return false, "Invalid options. (see /help info)"
			end
		else
			return false, "Invalid options. (see /help info)"
		end
	end,
})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name();
	minetest.after(10,get_info, name);
end)
