
local Domain = class:new{}

local domains = {}
local valid = {}

function Domain:instance(obj, the_class)

  local elements = {}
  local reverse = {}

  assert(the_class, "Class is nil")
  assert(not domains[the_class], "There already is a domain for this class")

  domains[the_class] = obj

  function obj:create (id, ...)
    if id == true then
      id = Domain:newId()
    end
    assert(valid[id], "invalid ID")
    assert(not elements[id], "ID already used")
    local element = the_class(...)
    elements[id] = element
    reverse[element] = id
    return element, id
  end

  function obj:get (id)
    assert(valid[id], "invalid ID")
    return elements[id]
  end

  function obj:getId (element)
    return reverse[element]
  end

  function obj:forElement (element)
    self:get(element.__class:getId(element))
  end

  function obj:destroy (id_or_element)
    local id = reverse[id_or_element] or id_or_element
    assert(valid[id], "invalid ID")
    if the_class.onDestroy then
      the_class:onDestroy(elements[id])
    end
    reverse[elements[id]] = nil
    elements[id] = nil
  end

  function obj:all ()
    return pairs(elements)
  end

  obj.__index = the_class

end

local function displayId (id)
  return tonumber(tostring(id):match "(0x%x+)")
end

function Domain:newId ()
  local new_id = { tostring = displayId }
  valid[new_id] = true
  return new_id
end

function Domain:validId (id)
  return valid[id]
end

function Domain:getId (element)
  local domain = domains[element.__class]
  assert(domain, "Element has no domain")
  return domain:getId(element)
end

return Domain
