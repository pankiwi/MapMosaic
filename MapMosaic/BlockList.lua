local class = require(current_folder ..  "/modules/classic")
local gen = require(current_folder .. "/generatorId")
local block = require(current_folder .. "/Block")

local BlockList = class:extend()

function BlockList:new()
  self.blocks = {}
  self.genId = gen()
end

function BlockList:add(b)
  if b then
  local id = self.genId:gen()
  
  b.id = id
  
  self.blocks[id] = b
  
  return b
  
  end
end

function BlockList:remplace(id, b)
  if b then
  b.id = id
  
  self.blocks[id] = b
  return b
  
  end
end

function BlockList:get(id)
  local out = self.blocks[id]
  
  if out then
    return out
  else 
    return self.blocks[1] --Air
  end
end

return BlockList
