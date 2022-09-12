--It is a type of revenue that allows you to copy
local class = require(current_folder ..  "/modules/classic")

local Block = class:extend()


local function clone(obj)
  local clone = {}
  setmetatable(clone, obj)
  obj.__index = obj
  return clone
end

--onCreate a new instance type
function Block:new()
  self.id = nil
  
  --flags
  self.is_solid = false
  self.is_readable = true
  self.is_updated = false
  self.is_draw = true
end

--onCreate Block
function Block:init(map, x, y)
  self.removeObject = false --flag if can remove remove block in table
  self.map = map --own map
  
  --The block is static
  self.x = x
  self.y = y
end

--generic functions
function Block:draw()
  --love.graphics.rectangle("fill", self.x, self.y, 32,32)
end

function Block:update(dt)
end

--its for destroy , use for The block is self-destined or is destroyed by things
function Block:destroy()
  self.removeObject = true --flag is true, now table can remove object after call remove()
end


--call on when block remove in table
function Block:remove()
  --TODO
end

function Block:putOff()
  self.removeObject = true
  self:remove()
end

function Block:create(...)
  local b = setmetatable({}, self)
  self.__index = self
  b:init(...)  
  
  return b
end


function Block:__tostring()
  return "Block " .. tostring(self.id)
end

return Block
