current_module = (...):gsub("%.init$", "")
current_folder = current_module:gsub("%.", "/")

--[[
  MapMosaic v0.1 by pankiwi
]]


function deepCopy(b, a)
for k,v in pairs(a) do
    if not b[k] then b[k] = v end
end

return b
end


MapMosaic = {}

MapMosaic.debug = false
MapMosaic.debug_showIdBlock = false

MapMosaic.settings = {
  tileWidth = 16,
  tileHeight = 16,
  omitZero = false --if is zero id, omit create block
}

function MapMosaic.setSetting(s)
  MapMosaic.settings = deepCopy(s, MapMosaic.settings)
end

function MapMosaic.debugMode(o)
  MapMosaic.debug= o or true
end

MapMosaic.CblockList = require(current_folder ..  "/BlockList")
MapMosaic.CMap = require(current_folder ..  "/Map")
MapMosaic.Block = require(current_folder ..  "/Block")


--global map
MapMosaic.blockList = require(current_folder ..  "/BlockList")()
