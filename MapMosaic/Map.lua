local class = require(current_folder ..  "/modules/classic")
local TSerial = require(current_folder ..  "/modules/TSerial")

function widthCirle(x1, y1, x2, y2, radius)
  local xd = x2 - x1
  local yd = y2 - y1;
  local d = xd * xd + yd * yd;
  
  if d <= radius*radius then return true else return false end
end

local function _NULL_() end


--[[
% new(tilemap, BlockList, events)

is in charge of managing functions that are related to the map, and the blocks

```lua
 Map(tilemap, BlockList, events)
```

@ Map (table) simple tilemap

@ [BlockList] (BlockList) map use global Block list but can set own block list

@ [events] (table) set callbacks event

: (Map) return self
]]


local Map = class:extend()

function Map:new(Map, BlockList, events)
  events = events or {} 
  
  self.blockList = BlockList or MapMosaic.blockList
  self.wasInitated = false
  --events preLoad,  onLoad, unLoad, Init
  self.events = {
    preLoad = events.preLoad or _NULL_,
    onLoad = events.onLoad or _NULL_,
    unLoad = events.unLoad or _NULL_,
    Init = events.Init or _NULL_
  }
  
  
  --If the map is loaded with incurrent values in the width and height, consider it corrupt and the extra values the eleminara and the voids will replace them by air block
  
  self.settings = MapMosaic.settings
  self.debug= MapMosaic.debug
  self.debug_showIdBlock= MapMosaic.debug_showIdBlock
  
  self.map = Map or {}
  --[[
  {
    
    {1,1,1,1,1},
    {1,0,0,0,1},
    {1,0,0,0,1},
    {1,1,1,1,1}
  }
  ]]
  
  local tw, th = self:getBounsMap()
  self.tileWidth = tw
  self.tileHeight = th
  self.width = tw * self.settings.tileWidth
  self.height = th * self.settings.tileHeight
 
  --They are values that change when the map is created
  self.blocks = {}
  self.x = 0
  self.y = 0
  
  --If you want temporary values that when the map is closed they are in the original state, in the unload event restart the values
end


--[[
% setEventOnLoad(function)

set callback event

```lua
 Map:setEventOnLoad(f)
```

@ f (function) set callback for event onLoad 

]]

function Map:setEventOnLoad(f)
  self.events.onLoad = f
end

--[[
% setEventPreLoad(function)

set callback event

```lua
 Map:setEventPreLoad(f)
```

@ f (function) set callback for event preLoad 

]]

function Map:setEventPreLoad(f)
  self.events.preLoad = f
end

--[[
% setEventUnLoad(function)

set callback event

```lua
 Map:setEventUnLoad(f)
```

@ f (function) set callback for event unLoad 

]]

function Map:setEventUnLoad(f)
  self.events.unLoad = f
end

--[[
% setEventInit(function)

set callback event

```lua
 Map:setEventInit(f)
```

@ f (function) set callback for event Init 

]]


function Map:setEventInit(f)
  self.events.Init = f
end


--[[
% setSetting(s)

set settings tilemap, settings is a table has values need map for build tilemap

```lua
setting = {
  tileWidth = 16,
  tileHeight = 16,
  omitZero = false --if is zero id, omit create block
}
```

```lua  
 Map:setSetting(s)
```

@ s (table) set setting of map
]]

function Map:setSetting(s)
  self.settings = deepCopy(MapMosaic.settings,s)
end

--[[
% setMapBySize(width, height)

create map by width and height,setMapBySize to generate the map values use the function ```lua Map:getIdBlockGen() ```, Useful for procedural generation or perlin noise

```lua
 Map:setMapBySize(width, height)
```

@ width (init) width of the map
@ height (init) height of the map
]]

function Map:setMapBySize(width, height)
  self.map = {}
  
  for i=1, height do
    table.insert(self.map, {})
    for j=1, width do
      table.insert(self.map[i], self:getIdBlockGen(j-1, i-1))
    end
  end
  
  local tw, th = self:getBounsMap()
  self.tileWidth = tw
  self.tileHeight = th
  self.width = tw * self.settings.tileWidth
  self.height = th * self.settings.tileHeight
end

--[[
% generateMap(width, height)

a function that has the objective of restarting the generation of the map, without having to create a new map, it only changes the values of the original map,generateMap to generate the map values use the function ```lua Map:getIdBlockGen() ```

```lua
 Map:generateMap(width, height)
```

@ [width] (init) width of the map
@ [height] (init) height of the map
]]

function Map:generateMap(width, height)
  if not self.tileWidth or not self.tileHeight then self:setMapBySize(width or 1, height or 1) return end
  
  for i,row in ipairs(self.map) do
        for j,tile in ipairs(row) do
          self.map[i][j] = self:getIdBlockGen(j-1, i-1)
        end
  end
end


--[[
% getIdBlockGen(tx, ty)

is a function that is used to generate the map tile in the functions generateMap, setMapBySize.replace the function with one that is suitable for the generation of tiles you are looking for

the output must be an int value, from that value a block with the same id is associated, if the id is not valid, it is replaced by 0

```lua
 Map:getIdBlockGen( tx, ty)
```


@ tx (init) tile position x

@ ty (init) tile position y

: (init) return id block


]]

function Map:getIdBlockGen( tx, ty)
 return 0
end


function Map:getBounsMap()
  local widths = {}
  
  for _,v in ipairs(self.map) do
     table.insert(widths, #v)
  end
  
  table.sort(widths, function (a, b)
      return a > b
  end)
  
  return widths[1] or 0, #self.map or 0
end


function Map:getIndex(tx, ty)
  return (ty * self.tileWidth)  + tx
end

--[[
% Map:toTile(x, y)

 World coords to tile coords

```lua
 Map:toTile(x, y)
```


@ x (float) world position x

@ y (float) world position y

: (init) return tx, ty


]]

function Map:toTile(x, y)
  return math.floor(((x - self.x)/self.settings.tileWidth )), math.floor((y - self.y)/self.settings.tileHeight )
end

--[[
% Map:tileTo(tx, ty)

 tile coords to world coords

```lua
 Map:tileTo(tx, ty)
```


@ tx (init) tile position x

@ ty (init) tile position y

: (float) return x, y


]]

function Map:tileTo(tx, ty)
  return self.x + tx  * self.settings.tileWidth,self.y + ty * self.settings.tileHeight 
end

function Map:getBlockData(b)
  if type(b) == "table" then
    return b.id, b.data
  end
  
  return b, {}
end

function Map:addBlock(obj, tx, ty)
  local bx, by = self:tileTo(tx - 1, ty - 1)
  local index =  self:getIndex(tx-1, ty-1)
  local id, data = self:getBlockData(obj)
  
  local b = (self.blockList:get(id) or self.blockList:get(0)):create(self, bx, by, unpack(data))
  
  if  ( not self.settings.omitZero and b.id == 0) or b.id ~= 0 then
  self.blocks[index] = b
  end
end


--[[
% Map:setBlock(obj, tx, ty, forzePlace)

 Set block in map, this function needs the maptile to be already loaded

```lua
 Map:setBlock(obj, tx, ty, forzePlace)
```


@ obj (init/table) is value block, can be number id or table has {id, data = {}}

@ tx (init) tile position x

@ ty (init) tile position y

@ [forzePlace] (bool) if is true, place block even when the space is already occupied

]]

function Map:setBlock(obj, tx, ty, forzePlace)
  if tx < 0 or tx > self.tileWidth - 1 or ty < 0 or ty > self.tileHeight - 1 then return  end
  
  local bx, by = self:tileTo(tx, ty);
  
  local index = self:getIndex(tx, ty);
  
  local id, data = self:getBlockData(obj)
  
  local b = (self.blockList:get(id) or self.blockList:get(0)):create(self, bx, by, unpack(data))
   
  if self.blocks[index] then
    self.blocks[index]:putOff()
  end
  
  self.blocks[index] = b
end

--[[
% Map:getBlock(tx, ty)

 to get blocks on the map, this function needs the maptile to be already loaded

```lua
 Map:getBlock(tx, ty)
```

@ tx (init) tile position x

@ ty (init) tile position y

: (Block) return Block object
]]

function Map:getBlock(tx, ty)
 if tx < 0 or tx > self.tileWidth - 1 or ty < 0 or ty > self.tileHeight - 1 then return nil end
  
  local index = self:getIndex(tx, ty)
  local b = self.blocks[index] or self.blocks[0]
 
  return b
end

--[[
% Map:removeBlock(tx, ty)

 remove blocks on the map, this function needs the maptile to be already loaded

```lua
 Map:removeBlock(tx, ty)
```

@ tx (init) tile position x

@ ty (init) tile position y
]]

function Map:removeBlock(tx, ty)
  if tx < 0 or tx > self.tileWidth - 1 or ty < 0 or ty > self.tileHeight - 1 then return  end
  
  local bx, by = self:tileTo(tx, ty);
  
  local index = self:getIndex(tx, ty);
  local b = self.blockList:get(0):create(self, bx, by)
   
  if self.blocks[index] then
    self.blocks[index]:putOff()
    if not self.settings.omitZero then self.blocks[index] = b else self.blocks[index] = nil end
  end
end

--[[
% Map:load(x, y)

 load the map to use this

```lua
 Map:load(x, y)
```

@ x (init) world position x

@ y (init) world position y
]]

function Map:load(x, y)
  self.x , self.y = x or self.x,  y or self.y
  
  --event
  self.events.preLoad(self)
  
  --Build Map
  
 for i,row in ipairs(self.map) do
      for j,tile in ipairs(row) do
        self:addBlock(tile, j, i)
      end
   end
  
  if not self.wasInitated then
    self.events.Init(self)
    self.wasInitated = true
  end
  
  --event
  self.events.onLoad(self)
end

--[[
% Map:update(dt)

  Update Map

```lua
 Map:update(dt)
```

@ dt (deltaTime) TODO
]]

function Map:update(dt)
  for i,v in pairs(self.blocks) do
    if v.is_updated then v:update(dt) end
  end
  
  for i,v in pairs(self.blocks) do
    if v.removeObject then 
      v:remove()
      table.remove(self.blocks, i)
    end
  end
  
end

--[[
% Map:draw()

  draw Map

```lua
 Map:draw()
```
]]

function Map:draw()
  for i,v in pairs(self.blocks) do
    if v.is_draw then v:draw() end
    if self.debug_showIdBlock then
      love.graphics.setColor(1,1,1)
      love.graphics.printf(v.id, v.x, v.y,100)
    end
  end
  
  if self.debug then
    love.graphics.setColor(1,0,1)
    love.graphics.rectangle("line",self.x, self.y, self.width, self.height)
    
    local f = love.graphics.getFont()
    
    local str = string.format("x: %0.1f, y: %0.1f, blocks: %s, tw: %s, th: %s, init: %s", self.x, self.y, #self.blocks, self.tileWidth, self.tileHeight, self.wasInitated)
    
    love.graphics.setColor(1,1,1)
    love.graphics.printf(str, self.x, self.y - f:getHeight(),1000)
    
  end
end

--[[
% Map:close()

  close map, destroy all object are in map

```lua
 Map:close()
```
]]

function Map:close()
  self.events.unLoad(self)
 
  for i,v in pairs(self.blocks) do
    v:putOff()
  end
  
  for i,v in pairs(self.blocks) do
    table.remove(self.blocks, i)
  end
end

--[[
% Map:reset()

  it is to reset the map

```lua
 Map:reset()
```
]]

function Map:reset()
  self:close()
  self:load()
end



--Beta functions, not are finish--

function Map:parseBlocks()
  local map = {}
  
  for i,row in ipairs(self.map) do
    table.insert(map, {})
    
    for j,tile in ipairs(row) do
      local b = self:getBlock(j-1, i-1)
      local id = 0
      
      if b and b.is_readable then id = b.id end
      
      if b and not b.is_readable then id = tile end
      
      table.insert(map[i], id)
    end
  end
  return map
end

-- x, y are in tiles 
function Map:queryTiles(x, y, h, w, f)
  for y_= y - h/2, y + h/2  do
    for x_ = x - w/2, x + w/2 do
      local tx, ty = math.floor(x_), math.floor(y_)
      
      f(self, tx, ty)
    end 
  end
end


-- x, y are in tiles
function Map:queryTilesArea(x, y, radius, f)
  self:queryTiles(x, y, radius, radius, function (Map, tx, ty)
    if widthCirle(x, y, tx, ty, radius) then
      f(self, tx, ty)
    end
  end)
end

--human read
function Map:export(name, hr, selfmap)
  love.filesystem.write(name .. ".tm" , TSerial.pack()) 
end

function Map:open(map)
  self.map = map
  
 local tw, th = self:getBounsMap()
  self.tileWidth = tw
  self.tileHeight = th
  self.width = tw * self.settings.tileWidth
  self.height = th * self.settings.tileHeight
end


return Map
