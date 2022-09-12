function love.load()
  removeMode = false
  require("MapMosaic")
  require("log")
  Log:init()
  
  BC = MapMosaic.CblockList() --new
  BC:add(MapMosaic.Block())
  
  local b = MapMosaic.Block()
  
  function b:draw()
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("fill", self.x, self.y, 16,16)
  end
  
  BC:add(b)
  
  M = MapMosaic.CMap(nil, BC)
  
  function M:getIdBlockGen(tx,ty)
    return 0
  end
  
  M:setMapBySize(20,20)
 
  M:setEventOnLoad(function()
      Log:print("load")
  end)
  M:setEventPreLoad(function()
      Log:print("pre load")
  end)
  M:setEventUnLoad(function()
    Log:print("unload")
  end)
  
  M:setEventInit(function()
    Log:print("Init")
  end)
  
  xg = 0
  yg = 0
  scale = 0.1
  
  
  M:load(20,20)
  
  
--  M:close()
end


function love.draw()
  local font = love.graphics.getFont()
  
  love.graphics.push()
  --love.graphics.scale(1)
--  love.graphics.translate(0, yg)
  
  M:draw()
  
  --[[
  local x, y, w, h, r = 10,10, 30, 30, 5.5
  
  for y_= y - h/2, y + h/2  do
    for x_ = x - w/2, x + w/2 do
      local tx, ty = M:tileTo(math.floor(x_), math.floor(y_))
      local xd = x - x_;
      local yd = y - y_;
      local d = xd * xd + yd * yd;
      
      if d <= r*r then
      
      love.graphics.rectangle("line", tx, ty, 16, 16,16)
      else 
        love.graphics.rectangle("fill", tx, ty, 16, 16,16)
        end
    end
  end
  ]]
 love.graphics.pop() 
 
  local fpsText = "FPS: "..tostring(love.timer.getFPS())
  love.graphics.print(fpsText, 0, 0)
  Log:draw(0, 20)
 
end

function love.update(dt)
  Log:export()
  M:update(dt)
end


function love.touchpressed(id, x, y)
  
  if y > 500  then removeMode = not removeMode  end
 -- if y > 500 and x < 100 then .filesystem.write("map", T)  end
  
  local tx, ty = M:toTile(x, y)
  
  if not removeMode then   
    M:setBlock(1,tx,ty, true)
    
    M:queryTiles(tx, ty, 5,5, function (self, tx, ty)
     M:setBlock(1,tx,ty, true)
     Log:print(tx .. "-" .. ty)
    end)
  else 
    
    M:queryTiles(tx, ty, 5,5, function (self, tx, ty)
         M:removeBlock(tx, ty)
         Log:print(tx .. "-" .. ty)
    end)
      
    end 
end

function love.touchreleased(id, x, y) 
end
