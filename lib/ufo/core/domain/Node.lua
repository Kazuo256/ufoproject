
local Node    = require 'lux.class' :new{}
local Domain  = require 'ufo.core.Domain'

function Node:instance (obj, name)

  local children = {}
  local reverse_index = {}
  local parent

  local to_be_added = {}
  local to_be_removed = {}

  function obj:getName ()
    return name
  end

  function obj:setParent (new_parent)
    parent = setmetatable({new_parent}, {__mode='v'})
  end

  function obj:getParent ()
    return parent and parent[1]
  end

  function obj:get (index_or_name)
    local child = children[index_or_name]
    if not child then
      if index_or_name:find '/' then
        local current = self
        for node_name in index_or_name:gmatch "([^/]+)" do
          current = current:get(node_name)
        end
        child = current
      else
        child = children[reverse_index[index_or_name]]
      end
    end
    return child
  end

  function obj:addChild (child)
    table.insert(to_be_added, child)
  end

  function obj:removeChild (child)
    table.insert(to_be_removed, child)
  end

  function obj:remove ()
    if parent then
      parent[1]:removeChild(self)
    end
  end

  function obj:onRemove ()
    -- Abstract
  end

  local function doAddChild (child)
    assert(child, "Cannot add nil node")
    local name = child:getName()
    assert(not reverse_index[name], "Duplicate node name '"..name.."'")
    table.insert(children, child)
    reverse_index[name] = #children
    child:setParent(self)
  end

  local function doRemoveChild (child)
    assert(child, "Cannot remove nil node.")
    local name = child:getName()
    local index = reverse_index[name]
    assert(index, "No such child node with name '"..name.."'")
    child:setParent(nil)
    table.remove(children, index)
    child:onRemove()
    for i=index,#children do
      reverse_index[children[i]:getName()] = i
    end
    reverse_index[name] = nil
  end

  function obj:flush ()
    for _,child in ipairs(to_be_removed) do
      doRemoveChild(child)
    end
    for _,child in ipairs(to_be_added) do
      doAddChild(child)
    end
  end

end

return Domain(Node)
