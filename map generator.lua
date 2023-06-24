local katt = require("libraries.KattEventsAPI")
local mg = {
   map_pos = nil,
   map_size = vectors.vec2(1,1),
   TARGET_MOVED = katt.newEvent(),
   TARGET_RESIZED = katt.newEvent(),
   shade = true,
   shades = {
      {shade=0.71,height_offset= -1},
      {shade=0.86,height_offset=  0},
      {shade=1,   height_offset=  1}
   },
   colors = {
   {clr="7fb238",blk="minecraft:grass_block"}, -- "Grass"
   {clr="f7e9a3",blk="minecraft:birch_planks"}, -- "Sand"
   {clr="c7c7c7",blk="minecraft:mushroom_stem"}, -- "Wool"
   {clr="ff0000",blk="minecraft:redstone_block"}, -- "Fire"
   {clr="a0a0ff",blk="minecraft:packed_ice"}, -- "Ice"
   {clr="a7a7a7",blk="minecraft:iron_block"}, -- "Metal"
   {clr="007c00",blk="minecraft:oak_leaves[persistent=true]"}, -- "Plant"
   {clr="ffffff",blk="minecraft:snow_block"}, -- "Snow"
   {clr="a4a8b8",blk="minecraft:clay"}, -- "Clay"
   {clr="976d4d",blk="minecraft:brown_mushroom_block"}, -- "Dirt"
   {clr="707070",blk="minecraft:stone"}, -- "Stone"
   --{"4040ff",nil}, -- "Water"
   {clr="8f7748",blk="minecraft:oak_planks"}, -- "Wood"
   {clr="fffcf5",blk="minecraft:diorite"}, -- "Quartz"
   {clr="d87f33",blk="minecraft:orange_wool"}, -- "Orange"
   {clr="b24cd8",blk="minecraft:magenta_wool"}, -- "Magenta"
   {clr="6699d8",blk="minecraft:light_blue_wool"}, -- "Light Blue"
   {clr="e5e533",blk="minecraft:yellow_wool"}, -- "Yellow"
   {clr="7fcc19",blk="minecraft:light_green_wool"}, -- "Light Green"
   {clr="f27fa5",blk="minecraft:pink_wool"}, -- "Pink"
   {clr="4c4c4c",blk="minecraft:gray_wool"}, -- "Gray"
   {clr="999999",blk="minecraft:light_gray_wool"}, -- "Light Gray"
   {clr="4c7f99",blk="minecraft:purple_wool"}, -- "Cyan"
   {clr="7f3fb2",blk="minecraft:blue_wool"}, -- "Purple"
   {clr="334cb2",blk="minecraft:brown_wool"}, -- "Blue"
   {clr="664c33",blk="minecraft:green_wool"}, -- "Brown"
   {clr="667f33",blk="minecraft:red_wool"}, -- "Green"
   {clr="993333",blk="minecraft:black_wool"}, -- "Red"
   {clr="191919",blk="minecraft:gold_block"}, -- "Black"
   {clr="faee4d",blk="minecraft:diamond_block"}, -- "Gold"
   {clr="5cdbd5",blk="minecraft:lapis_block"}, -- "Diamond"
   {clr="4a80ff",blk="minecraft:emerald_block"}, -- "Lapiz"
   {clr="00d93a",blk="minecraft:spruce_planks"}, -- "Emerald"
   {clr="815631",blk="minecraft:nether_bricks"}, -- "Podzol"
   {clr="700200",blk="minecraft:white_terracotta"}, -- "Nether"
   {clr="d1b1a1",blk="minecraft:orange_terracotta"}, -- "Teracotta White"
   {clr="9f5224",blk="minecraft:magenta_terracotta"}, -- "Teracotta Orange"
   {clr="95576c",blk="minecraft:light_blue_terracotta"}, -- "Teracotta Magenta"
   {clr="706c8a",blk="minecraft:yellow_terracotta"}, -- "Teracotta Light Blue"
   {clr="ba8524",blk="minecraft:lime_terracotta"}, -- "Teracotta Yellow"
   {clr="677535",blk="minecraft:pink_terracotta"}, -- "Teracotta Light Green"
   {clr="a04d4e",blk="minecraft:gray_terracotta"}, -- "Teracotta Pink"
   {clr="392923",blk="minecraft:light_gray_terracotta"}, -- "Teracotta Gray"
   {clr="876b62",blk="minecraft:cyan_terracotta"}, -- "Teracotta Light Gray"
   {clr="575c5c",blk="minecraft:purple_terracotta"}, -- "Teracotta Cyan"
   {clr="7a4958",blk="minecraft:blue_terracotta"}, -- "Teracotta Purple"
   {clr="4c3223",blk="minecraft:brown_terracotta"}, -- "Teracotta Brown"
   {clr="4c522a",blk="minecraft:green_terracotta"}, -- "Teracotta Green"
   {clr="8e3c2e",blk="minecraft:red_terracotta"}, -- "Teracotta Red"
   {clr="251610",blk="minecraft:black_terracotta"}, -- "Teracotta Black"
   {clr="bd3031",blk="minecraft:crimson_nylium"}, -- "Crimson Nylium"
   {clr="943f61",blk="minecraft:crimson_stem"}, -- "Crimson Stem"
   {clr="5c191d",blk="minecraft:crimson_hyphae"}, -- "Crimson Hyphae"
   {clr="167e86",blk="minecraft:warped_nylium"}, -- "Warped Nylium"
   {clr="3a8e8c",blk="minecraft:warped_stem"}, -- "Warped Stem"
   {clr="562c3e",blk="minecraft:warped_hyphae"}, -- "Warped Hyphae"
   {clr="14b485",blk="minecraft:warped_wart_block"}, -- "Warped Wart Block"
   {clr="646464",blk="minecraft:deepslate"}, -- "Deepslate"
   {clr="d8af93",blk="minecraft:raw_iron_block"}, -- "Raw Iron"
   --{"7fa796",nil}, -- "Glow Lichen"
   },
   instruction = {},
   pre = {}
}

for _, value in pairs(mg.colors) do value.clr = vectors.hexToRGB(value.clr) end

function mg:setMapPos(pos)
   local lmp = mg.map_pos
   local nmp = vectors.vec2((math.floor((pos.x-64)/128)+0.5)*128,(math.floor((pos.z-64)/128)+0.5)*128)
   if nmp ~= lmp then
      mg.map_pos = nmp
      mg.TARGET_MOVED:invoke(nmp)
   end
   return self
end

function mg:clearPre()
   mg.pre = {}
   for y = 1, 128, 1 do
      local r = {}
      for x = 1, 128, 1 do
         r[x] = {}
      end
      mg.pre[y] = r
   end
end

mg:clearPre()

---@param x number
---@param y number
---@return table
function mg:getPixel(x,y)
   return mg.pre[x+1][y+1]
end


function mg:setMapSize(x,y)
   local new_size = vectors.vec2(x,y)
   if self.map_size ~= new_size then
      self.map_size = new_size
      mg.TARGET_RESIZED:invoke(x,y)
   end
   return self
end


local pI = 1
local phase = 0
local buisy = false
local px = 0
local pres = 2
local pratio = 128/pres
local py = 0
local preview = textures:newTexture("preview",128,128)
local heightmap = textures:newTexture("preview_heightmap",128,128)
local prestruction = textures:newTexture("instruction",128,128)

local source_queue = {}

---@param texture Texture
function mg.queueMap(texture)
   table.insert(source_queue,texture)
end

function mg.startGenerating()
   phase = 0
   buisy = true
   px = 0
   py = 0
   pI = 1
   pres = 2
   pratio = 128/pres
end

local source = textures.map
local source_res = textures.map:getDimensions()


---@param rgb Vector3
---@return Vector3, integer, integer
function mg.findClosestMapColor(rgb)
   local final_color
   local shade = 0
   local clrid = 0
   local dist = 999999999
   for ci, clr_data in pairs(mg.colors) do
      for si, shata in pairs(mg.shades) do
         local clr = clr_data.clr
         if mg.shade then
            clr = clr * shata.shade
         end
         local d = (clr-rgb):length()
         if d < dist then
            final_color = clr
            shade = shata.height_offset
            dist = d
            clrid = ci
         end
      end
   end
   return final_color,shade,clrid
end

local last_block_id
local last_offset
local height = 128
local line_origin
local block_line

events.TICK:register(function ()
   if buisy then
      for _ = 1, 128, 1 do
         if buisy then
            if phase == 0 then
               local clr,h,cid = mg.findClosestMapColor(
                  source:getPixel(
                     math.clamp((px * pratio + 1),0,127) / 128 * source_res.x,
                     math.clamp((py * pratio + 1),0,127) / 128 * source_res.y).xyz)
               preview:fill(px * pratio,py * pratio,pratio,pratio,clr)
               --heightmap:fill(px * pratio,py * pratio,pratio,pratio,vectors.vec4(h,h,h,1))
               --prestruction:fill(px * pratio,py * pratio,pratio,pratio,vectors.vec4((cid-1)/128,h,0,1))
               local p = mg:getPixel(px * pratio,py * pratio)
               p[1] = cid
               p[2] = h
               
               px = px + 1
               if pI ~= 1 and px % 2 == 0 and py % 2 == 0 then
                  px = px + 1
               end
               if px > pres-1 then
                  px = 0
                  py = py + 1
                  preview:update()
                  --heightmap:update()
                  prestruction:update()
                  if py > pres-1 then
                     px = 0
                     py = 0
                     pres = pres * 2
                     pratio = 128/pres
                     if pI <= 6 then pI = pI + 1 else
                        phase = 1
                        py = 0
                        px = 0
                     end
                  end
               end
            elseif phase == 1 and type(mg.map_pos) ~= "nil" then
               local p = mg:getPixel(px,py)
               local block_id = p[1]
               local offset = p[2]
               height = height + offset
               local current_pos = vectors.vec3(px, height, py)
               if not line_origin or py == 0 then 
                  line_origin = current_pos
                  table.insert(mg.instruction,"//pos1 "..mg.map_pos.x + line_origin.x..","..line_origin.y..","..mg.map_pos.y + line_origin.z..",")
                  block_line = block_id
               end
               if (last_block_id ~= block_id and last_offset ~= offset) or py >= 127  then
                  table.insert(mg.instruction,"//pos2 "..mg.map_pos.x + current_pos.x..","..current_pos.y..","..mg.map_pos.y + current_pos.z..",")
                  table.insert(mg.instruction,"//line "..mg.colors[block_line-1].blk)
                  line_origin = nil
               end

               last_block_id = block_id
               last_offset = offset
               py = py + 1
               if py >= 128 then
                  py = 0
                  px = px + 1
                  height = 128
                  last_offset = 0
                  if px >= 128 then
                     buisy = false
                     print("Finished")
                  end
               end
            end
         end
      end
   end
end)
mg.startGenerating()
return mg