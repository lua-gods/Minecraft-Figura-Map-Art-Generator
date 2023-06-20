local panel = require("libraries.panel")
local page = panel:newPage()
local labelLib = require("libraries.GNLabelLib")

local map = require("map generator")
textures:newTexture("preview",128,128):applyFunc(0,0,128,128,function ()
   return vectors.vec4(math.random(),math.random(),math.random(),1)
end)

local preview_slider = page:newElement("slider"):setText("Source / Preview"):setItemCount(5)

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

local task_orig = models.hud:newSprite("previewOriginal"):texture(textures.map)
local task_gen = models.hud:newSprite("previewGenerated"):texture(textures.preview)

events.WORLD_RENDER:register(function (delta)
   local from = labelLib.pos2UI(-95,90,0,-0.5)
   local size = client:getScaledWindowSize().x+from.x - 5
   if panel.visible then
      task_orig:pos(from.x,from.y+size,0):setSize(size,size):visible(true)
      local mat = matrices.mat4()
      mat.c1 = vectors.vec4(1,0,1,0)
      mat:translate(from.x,from.y+size,(preview_slider.selected - 1) / (preview_slider.count - 1) * size)
      task_gen:setMatrix(mat):setSize(size,size):visible(true)
   else
      task_orig:visible(false)
      task_gen:visible(false)
   end
end)

map.TARGET_MOVED:register(generate_borders)
map.TARGET_RESIZED:register(generate_borders)

return page