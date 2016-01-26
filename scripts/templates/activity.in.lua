# outfmt = "activities/%sActivity.lua"
# local classname = id.."Activity"

local $(classname) = require 'lux.class' :new{}

$(classname):inherit(require 'Activity')

function $(classname):instance (obj, ...)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    -- Start here
  end

end

return $(classname)
