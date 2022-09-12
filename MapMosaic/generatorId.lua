local class = require(current_folder ..  "/modules/classic")

local gId = class:extend()

function gId:new()
  self.lastId = -1
end

function gId:gen()
  self.lastId = self.lastId + 1
  
  return self.lastId
end


return gId
