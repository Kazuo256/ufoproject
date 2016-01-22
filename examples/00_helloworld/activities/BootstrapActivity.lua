
local BootstrapActivity = require 'lux.class' :new{}

BootstrapActivity:inherit(require 'ufo.core.Activity')

function BootstrapActivity:instance (obj)

  self:super(obj)

  function obj.__accept:Load (engine)
    local gfxserver = engine:loadServer "Graphics"
    gfxserver:resetSteps(1)
    gfxserver:setStep(1, 'hello', true)
    print "go"
  end

end

return BootstrapActivity
