function love.conf(t)
 t.title = "LibMap"
 t.identity = "LibMap"
 t.window.width = 360
 t.window.height = 730
 t.version = "11.4"
 t.externalstorage = true
 
 if love._os == "iOS" then
    t.window.borderless = true
  elseif love._os == "Android" then
    t.window.fullscreen = true
  end
  
end
