
local Node = class:new{}

local assert        = assert
local ipairs        = ipairs
local setmetatable  = setmetatable
local table         = table
local setfenv       = setfenv

function Node:instance (obj, name)

  setfenv(1, obj)

  local children = {}
  local reverse_index = {}
  local parent

  local to_be_added = {}
  local to_be_removed = {}

  function getName ()
    return name
  end

  function setParent (new_parent)
    parent = setmetatable({new_parent}, {__mode='v'})
  end

  function getParent ()
    return parent and parent[1]
  end

  function get (index_or_name)
    local child = children[index_or_name]
    if not child then
      if index_or_name:find '/' then
        local current = self
        for node_name in index_or_name:gmatch "([^/]+)" do
          current = current.get(node_name)
        end
        child = current
      else
        child = children[reverse_index[index_or_name]]
      end
    end
    return child
  end

  function addChild (child)
    table.insert(to_be_added, child)
  end

  function removeChild (child)
    table.insert(to_be_removed, child)
  end

  function remove ()
    if parent then
      parent[1].removeChild(self)
    end
  end

  function onRemove ()
    -- Abstract
  end

  local function doAddChild (child)
    assert(child, "Cannot add nil node")
    local name = child.getName()
    assert(not reverse_index[name], "Duplicate node name '"..name.."'")
    table.insert(children, child)
    reverse_index[name] = #children
    child.setParent(self)
  end

  local function doRemoveChild (child)
    assert(child, "Cannot remove nil node.")
    local name = child.getName()
    local index = reverse_index[name]
    assert(index, "No such child node with name '"..name.."'")
    child.setParent(nil)
    table.remove(children, index)
    child.onRemove()
    for i=index,#children do
      reverse_index[children[i].getName()] = i
    end
    reverse_index[name] = nil
  end

  function flush ()
    for _,child in ipairs(to_be_removed) do
      doRemoveChild(child)
    end
    for _,child in ipairs(to_be_added) do
      doAddChild(child)
    end
  end

end

local root

function Node:root ()
  return root
end

Node = require 'ufo.Domain' (Node)
root = Node.create(true, "root")

return Node
