local args = {...}
local branch
if not args[1] then
    branch = "main"
elseif args[1] == "main" or args[1] == "dev" then
    branch = args[1]
else
    print("Usage: install_hexlator [main|dev] [install path]")
    shell.exit()
end
local raw_url = string.format("https://raw.githubusercontent.com/Zizazar/HexLator/%s/", branch)

local install_path
if not args[2] then
    install_path = "/programfiles/hexlator/"
else
    install_path = args[2].."/hexlator/"
end

shell.execute("delete", install_path)

shell.execute("wget", raw_url.."hexlator.lua", install_path.."hexlator.lua")
shell.execute("wget", raw_url.."hexget.lua", install_path.."hexget.lua")
shell.execute("wget", raw_url.."symbol-registry.json", install_path.."symbol-registry.json")
shell.execute("wget", raw_url.."hexxyedit.lua", install_path.."hexxyedit.lua")
shell.execute("wget", raw_url.."hexload.lua", install_path.."hexload.lua")

shell.execute("delete", "/startup.lua")
shell.execute("wget", raw_url.."modifired_startup.lua", "/startup.lua")

os.reboot()
