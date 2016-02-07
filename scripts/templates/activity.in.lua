# outfmt = "activities/%sActivity.lua"
# local classname = id.."Activity"

local $(classname) = class:new{}

$(classname):inherit(require 'Activity')

function $(classname):instance (_ENV, ...)
  
  self:super(_ENV)

  function obj.__accept:Load (engine)
    -- Start here
  end

end

return $(classname)
