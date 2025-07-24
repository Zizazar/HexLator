-- startup modifired by hexlator
shell.setAlias("hexget", "/programfiles/hexlator/hexget.lua")
shell.setAlias("hexxyedit", "/programfiles/hexlator/hexxyedit.lua")
shell.setAlias("hexload", "/programfiles/hexlator/hexload.lua")

local completion = require "cc.shell.completion"
local file_complete = completion.build(completion.file)

shell.setCompletionFunction("hexxyedit", file_complete)
shell.setCompletionFunction("hexload", file_complete)
