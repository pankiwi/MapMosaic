local class = require(current_folder ..  "/modules/classic")

--a tiny example a map Manager

local MapManager = class:extend()

function MapManager:new()
  self.maps = {}
  self.current = nil
  self.after= nil
  self.x = 0
  self.y = 0
end


function MapManager:add(name, map)
  if not self.maps[name] then
    self.maps[name] = map
  end
end

function MapManager:remplace(name, newMap)
  if self.maps[name] then
    self.maps[name] = map
  end
end

function MapManager:remove(name)
  if self.maps[name] then
    self.maps[name] = nil
  end
end

function MapManager:getMap(name)
  return self.maps[name] 
end

function MapManager:map()
  return self.current
end

function MapManager:mapAfter()
  return self.after
end

function MapManager:close()
  if self.current ~= nil then
    self.after = self.current
    self.current:close()
  end
end

function MapManager:update(dt)
  if self.current ~= nil then
    self.current:update(dt)
  end
end

function MapManager:draw()
  if self.current ~= nil then
     self.current:draw()
  end
end

function MapManager:open(name, data)
  local map = self:getMap(name)
  
  if self.current ~= nil then
    self:close()
  end
  
  if map ~= nil then
  map:load(self.x, self.y, unpack(data))
  
  self.current = map
  end
end
