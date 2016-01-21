
local Domain = require 'lux.class' :new{}

local domains = {}

function Domain:instance(obj, class)

  local elements = {}
  local reverse = {}

  assert(class, "Class is nil")
  assert(not domains[class], "There already is a domain for this class")

  domains[class] = obj

  function obj:create (id, ...)
    assert(id, "ID is nil")
    assert(not elements[id], "ID already used")
    local element = class(...)
    elements[id] = element
    reverse[element] = id
    return element
  end

  function obj:get (id)
    return elements[id]
  end

  function obj:getId (element)
    return reverse[element]
  end

  function obj:destroy (id_or_element)
    local id = reverse[id_or_element] or id_or_element
    reverse[elements[id]] = nil
    elements[id] = nil
  end

  function obj:all ()
    return pairs(elements)
  end

end

function Domain:getId (element)
  local domain = domains[element.__class]
  assert(domain, "Element has no domain")
  return domain:getId(element)
end

return Domain
