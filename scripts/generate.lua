
local template_type, name = ...

local macro = require 'lux.macro'
local port  = require 'lux.portable'

local templates = {
  Activity = {
    outdir = "activities",
    code = [[

$! local classname = name.."Activity"
local $=classname=$ = require 'lux.class' :new{}

$=classname=$:inherit(require 'Activity')

function $=classname=$:instance (obj, ...)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    -- Start here
  end

end

return $=classname=$

]]
  }
}

local template = templates[template_type]
local output_path = template.outdir.."/"..name.."Activity.lua"

print("Generating "..output_path)

local output = io.open(output_path, "w")
local env = setmetatable( { name = name }, { __index = port.getEnv() })
output:write(macro.process(template.code, env))
