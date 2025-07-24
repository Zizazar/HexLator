local hexlator = require("hexlator")

local args = {...}

if not args[1] then
    print("Usage: hexload <file path>")
    return
end

local file_path = shell.resolve(args[1])

-- file checks
if not fs.exists(file_path) then 
    print("File not exists")
    return
end
if fs.isDir(file_path) then
    print("Cannot edit a directory.")
    return
end

local version = "HexLoad v1.0"
print(version)
print("-------------")


local function load_file(path)
    local file = io.open(path, "r")
    local line = file:read()
    local content = ""
    while line do
        content = content .. line
        line = file:read()
    end
    file:close()
    return content
end

local function wait_for_focus(focal_port)
    while not focal_port.hasFocus() do
        print("Waiting for focus...")
        sleep(2)
    end
end

local program = load_file(file_path)
local compiled = hexlator.compile(program, true, false)

-- focal port
local focal_port = peripheral.find("focal_port")

if not focal_port then
    print("Cannot write! No focal port found.")
    return
end

if not focal_port.hasFocus() then
    print("Cannot write! No focus found.")
    wait_for_focus(focal_port)
end

-- write compiled iota to focus if possible
if not focal_port.canWriteIota() then
    print("Cannot write! This won't compile!")
    return
else
    focal_port.writeIota(compiled)
    print("Compiled to focus!")
end
