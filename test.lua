
dofile("api.lua")

info.set_info(1, "hmk")
info.set_info(1, "")
info.set_info(2, "smk")


for x in info.info_iter() do
    print(x)
end

param = "/info set 1 smk loves food"
msg = param:sub(13)

--[[ param = param:split(" ")
cmd, i = param[1], param[2]

print(cmd)
print(i)
--]]
print(msg)
