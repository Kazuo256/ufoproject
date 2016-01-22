
local BootstrapActivity = require 'lux.class' :new{}

BootstrapActivity:inherit(require 'ufo.core.Activity')

function BootstrapActivity:instance (obj)

  self:super(obj)

  function obj.__accept:Load ()
    print "Well met!"
  end

end

return BootstrapActivity
