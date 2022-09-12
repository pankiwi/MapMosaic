Log = {
  registry = ""
}

Log.__index = Log

function Log:init()
  Log:add("|| Init registry " .. love.system.getOS() .. " " .. os.date("%m/%d/%Y"))
end

function Log:add(Txt)
  self.registry = self.registry .. "\n" .. Txt
end

function Log:append(Txt)
  self.registry = self.registry .. Txt
end

function Log:clear()
  Log:add("|| [clear]")
end

function Log:print(Txt, level)
  local anex = ((level == nil or level == "i") and "[i]") or ((level == "w") and "[w]") or ((level == nil or level == "e") and "[e]") 
  
  Log:add(anex .. " " .. Txt)
end

function Log:export()
  love.filesystem.write("lastLog", self.registry)
end

function Log:draw(x, y)
  love.graphics.push()
  local line = self.registry:gsub("\r", "")
  love.graphics.printf(string.match(line, "[^%c]*$"), x, y, 800,"left")
  love.graphics.pop()
end
