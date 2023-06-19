local panel = require("libraries.panel")
local page = panel:newPage()


local map = require("map generator")

page:newElement("slider"):setText("Split Width").ON_SLIDE:register(function (value)
   map:setMapSize(value,map.map_size.y)
end)
page:newElement("slider"):setText("Split Height").ON_SLIDE:register(function (value)
   map:setMapSize(map.map_size.x,value)
end)
page:newElement("toggleButton"):setText("Show Map Preview")
page:newElement("margin")
page:newElement("button"):setText("Select Area").ON_PRESS:register(function ()
   map:setMapPos(player:getPos())
end)

local function generate_borders()
   models.world:removeTask()
   local extrude = map.map_size.x * map.map_size.y
   models.world:newSprite("northern border"):texture(textures.forcefield):setSize((128 * extrude)*16,(320+64)*16):pos(map.map_pos.x * 16,320 * 16,map.map_pos.y*16):rot(0,180,0):color(1,0,0)
   models.world:newSprite("western border") :texture(textures.forcefield):setSize(128*16,(320+64)*16):pos(map.map_pos.x * 16,320 * 16,(map.map_pos.y+128)*16):rot(0,270,0):color(0,0,1)
   models.world:newSprite("southern border"):texture(textures.forcefield):setSize((128 * extrude)*16,(320+64)*16):pos((map.map_pos.x + 128 * extrude) * 16,320 * 16,(map.map_pos.y+128)*16):rot(0,0,0):color(1,0,0)
   models.world:newSprite("eastern border") :texture(textures.forcefield):setSize(128*16,(320+64)*16):pos((map.map_pos.x + 128 * extrude)*16,320*16,(map.map_pos.y)*16):rot(0,90,0):color(0,0,1)
end

map.TARGET_MOVED:register(generate_borders)
map.TARGET_RESIZED:register(generate_borders)

print()

return page