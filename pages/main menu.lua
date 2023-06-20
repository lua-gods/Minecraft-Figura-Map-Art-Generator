local panel = require("libraries.panel")
local page = panel:newPage()
local labelLib = require("libraries.GNLabelLib")

local map = require("map generator")

page:newElement("slider"):setText("Source / Preview"):setItemCount(5)

page:newElement("margin")
page:newElement("toggleButton"):setText("Depth")
page:newElement("margin")

page:newElement("slider"):setText("Split Width").ON_SLIDE:register(function (value)
   map:setMapSize(value,map.map_size.y)
end)
page:newElement("slider"):setText("Split Height").ON_SLIDE:register(function (value)
   map:setMapSize(map.map_size.x,value)
end)
page:newElement("margin")
page:newElement("button"):setText("Select Area").ON_PRESS:register(function ()
   map:setMapPos(player:getPos())
end)

local function generate_borders()
   models.world:removeTask()
   if map.map_pos then
      local extrude = map.map_size.x * map.map_size.y
      models.world:newSprite("northern border"):texture(textures.forcefield):setSize((128 * extrude)*16,(320+64)*16):pos(map.map_pos.x * 16,320 * 16,map.map_pos.y*16):rot(0,180,0):color(1,0,0)
      models.world:newSprite("western border") :texture(textures.forcefield):setSize(128*16,(320+64)*16):pos(map.map_pos.x * 16,320 * 16,(map.map_pos.y+128)*16):rot(0,270,0):color(0,0,1)
      models.world:newSprite("southern border"):texture(textures.forcefield):setSize((128 * extrude)*16,(320+64)*16):pos((map.map_pos.x + 128 * extrude) * 16,320 * 16,(map.map_pos.y+128)*16):rot(0,0,0):color(1,0,0)
      models.world:newSprite("eastern border") :texture(textures.forcefield):setSize(128*16,(320+64)*16):pos((map.map_pos.x + 128 * extrude)*16,320*16,(map.map_pos.y)*16):rot(0,90,0):color(0,0,1)
   end
end

events.WORLD_RENDER:register(function (delta)
   local from = labelLib.pos2UI(-95,90,0,-0.5)
   local size = client:getScaledWindowSize().x+from.x - 5
   if panel.visible then
      models.hud:newSprite("preview"):texture(textures.map):pos(from.x,from.y+size,0):setSize(size,size):visible(true)
   else
      models.hud:newSprite("preview"):visible(false)
   end
end)

map.TARGET_MOVED:register(generate_borders)
map.TARGET_RESIZED:register(generate_borders)

return page