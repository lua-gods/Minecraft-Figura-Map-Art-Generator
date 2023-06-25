local katt = require("libraries.KattEventsAPI")
local map = {
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
   {clr="#7fb238",blk="minecraft:grass_block"}, -- "Grass"
   {clr="#f7e9a3",blk="minecraft:birch_planks"}, -- "Sand"
   {clr="#c7c7c7",blk="minecraft:mushroom_stem"}, -- "Wool"
   {clr="#ff0000",blk="minecraft:redstone_block"}, -- "Fire"
   {clr="#a0a0ff",blk="minecraft:packed_ice"}, -- "Ice"
   {clr="#a7a7a7",blk="minecraft:iron_block"}, -- "Metal"
   {clr="#007c00",blk="minecraft:oak_leaves[persistent=true]"}, -- "Plant"
   {clr="#ffffff",blk="minecraft:snow_block"}, -- "Snow"
   {clr="#a4a8b8",blk="minecraft:clay"}, -- "Clay"
   {clr="#976d4d",blk="minecraft:brown_mushroom_block"}, -- "Dirt"
   {clr="#707070",blk="minecraft:stone"}, -- "Stone"
   --{"4040ff",nil}, -- "Water"
   {clr="#8f7748",blk="minecraft:oak_planks"}, -- "Wood"
   {clr="#fffcf5",blk="minecraft:diorite"}, -- "Quartz"
   {clr="#d87f33",blk="minecraft:orange_wool"}, -- "Orange"
   {clr="#b24cd8",blk="minecraft:magenta_wool"}, -- "Magenta"
   {clr="#6699d8",blk="minecraft:light_blue_wool"}, -- "Light Blue"
   {clr="#e5e533",blk="minecraft:yellow_wool"}, -- "Yellow"
   {clr="#7fcc19",blk="minecraft:light_green_wool"}, -- "Light Green"
   {clr="#f27fa5",blk="minecraft:pink_wool"}, -- "Pink"
   {clr="#4c4c4c",blk="minecraft:gray_wool"}, -- "Gray"
   {clr="#999999",blk="minecraft:light_gray_wool"}, -- "Light Gray"
   {clr="#4c7f99",blk="minecraft:cyan_wool"}, -- "Cyan"
   {clr="#7f3fb2",blk="minecraft:purple_wool"}, -- "Purple"
   {clr="#334cb2",blk="minecraft:blue_wool"}, -- "Blue"
   {clr="#664c33",blk="minecraft:brown_wool"}, -- "Brown"
   {clr="#667f33",blk="minecraft:green_wool"}, -- "Green"
   {clr="#993333",blk="minecraft:red_wool"}, -- "Red"
   {clr="#191919",blk="minecraft:black_wool"}, -- "Black"
   {clr="#faee4d",blk="minecraft:gold_block"}, -- "Gold"
   {clr="#5cdbd5",blk="minecraft:diamond_block"}, -- "Diamond"
   {clr="#4a80ff",blk="minecraft:lapis_block"}, -- "Lapiz"
   {clr="#00d93a",blk="minecraft:emerald_block"}, -- "Emerald"
   {clr="#815631",blk="minecraft:spruce_planks"}, -- "Podzol"
   {clr="#700200",blk="minecraft:nether_bricks"}, -- "Nether"
   {clr="#d1b1a1",blk="minecraft:white_terracotta"}, -- "Teracotta White"
   {clr="#9f5224",blk="minecraft:orange_terracotta"}, -- "Teracotta Orange"
   {clr="#95576c",blk="minecraft:magenta_terracotta"}, -- "Teracotta Magenta"
   {clr="#706c8a",blk="minecraft:light_blue_terracotta"}, -- "Teracotta Light Blue"
   {clr="#ba8524",blk="minecraft:yellow_terracotta"}, -- "Teracotta Yellow"
   {clr="#677535",blk="minecraft:lime_terracotta"}, -- "Teracotta Light Green"
   {clr="#a04d4e",blk="minecraft:pink_terracotta"}, -- "Teracotta Pink"
   {clr="#392923",blk="minecraft:gray_terracotta"}, -- "Teracotta Gray"
   {clr="#876b62",blk="minecraft:light_gray_terracotta"}, -- "Teracotta Light Gray"
   {clr="#575c5c",blk="minecraft:cyan_terracotta"}, -- "Teracotta Cyan"
   {clr="#7a4958",blk="minecraft:purple_terracotta"}, -- "Teracotta Purple"
   {clr="#4c3e5c",blk="minecraft:blue_terracotta"}, -- "Teracotta Purple"
   {clr="#4c3223",blk="minecraft:brown_terracotta"}, -- "Teracotta Brown"
   {clr="#4c522a",blk="minecraft:green_terracotta"}, -- "Teracotta Green"
   {clr="#8e3c2e",blk="minecraft:red_terracotta"}, -- "Teracotta Red"
   {clr="#251610",blk="minecraft:black_terracotta"}, -- "Teracotta Black"
   {clr="#bd3031",blk="minecraft:crimson_nylium"}, -- "Crimson Nylium"
   {clr="#943f61",blk="minecraft:crimson_stem"}, -- "Crimson Stem"
   {clr="#5c191d",blk="minecraft:crimson_hyphae"}, -- "Crimson Hyphae"
   {clr="#167e86",blk="minecraft:warped_nylium"}, -- "Warped Nylium"
   {clr="#3a8e8c",blk="minecraft:warped_stem"}, -- "Warped Stem"
   {clr="#562c3e",blk="minecraft:warped_hyphae"}, -- "Warped Hyphae"
   {clr="#14b485",blk="minecraft:warped_wart_block"}, -- "Warped Wart Block"
   {clr="#646464",blk="minecraft:deepslate"}, -- "Deepslate"
   {clr="#d8af93",blk="minecraft:raw_iron_block"}, -- "Raw Iron"
   --{"7fa796",nil}, -- "Glow Lichen"
   },
   instruction = {},
   pre = {},
   buisy = false,
   preview_mode = true
}

for _, value in pairs(map.colors) do value.clr = vectors.hexToRGB(value.clr) end

function map:setMapPos(pos)
   local lmp = map.map_pos
   local nmp = vectors.vec2((math.floor((pos.x-64)/128)+0.5)*128,(math.floor((pos.z-64)/128)+0.5)*128)
   if nmp ~= lmp then
      map.map_pos = nmp
      map.TARGET_MOVED:invoke(nmp)
   end
   return self
end

function map:clearPre()
   map.pre = {}
   for y = 1, 128, 1 do
      local r = {}
      for x = 1, 128, 1 do
         r[x] = {}
      end
      map.pre[y] = r
   end
end

map:clearPre()

---@param x number
---@param y number
---@return table
function map:getPixel(x,y)
   return map.pre[x+1][y+1]
end


function map:setMapSize(x,y)
   local new_size = vectors.vec2(x,y)
   if self.map_size ~= new_size then
      self.map_size = new_size
      map.TARGET_RESIZED:invoke(x,y)
   end
   return self
end


local pI = 1
local phase = 0
local px = 0
local pres = 2
local pratio = 128/pres
local py = 0
local preview = textures:newTexture("preview",128,128)
local heightmap = textures:newTexture("preview_heightmap",128,128)
local prestruction = textures:newTexture("instruction",128,128)

local source_queue = {}

---@param texture Texture
function map.queueMap(texture)
   table.insert(source_queue,texture)
end

function map.startGenerating()
   map.preview_mode = false
   phase = 0
   map.buisy = true
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
function map.findClosestMapColor(rgb)
   local final_color
   local shade = 0
   local clrid = 0
   local dist = 999999999
   for ci, clr_data in pairs(map.colors) do
      for si, shata in pairs(map.shades) do
         local clr = clr_data.clr
         if map.shade then
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

local splitX = 0
local splitY = 0

local function progress(message,percentage)
   host:setActionbar('[{"text":"'..message..'"},{"color":"red","text":"'..("|"):rep(percentage*20)..'"},{"color":"black","text":"'..("|"):rep((1-percentage)*20)..'"}]')
end

events.TICK:register(function ()
   if map.buisy or map.preview_mode then
      for _ = 1, 128, 1 do
         if map.buisy or map.preview_mode  then
            if phase == 0 then
               local clr,h,cid = map.findClosestMapColor(
                  source:getPixel(
                     math.map(math.clamp((px * pratio),0,128) / 128,0,1,splitX/map.map_size.x,(splitX+1)/map.map_size.x) * source_res.x,
                     math.map(math.clamp((py * pratio),0,128) / 128,0,1,splitY/map.map_size.y,(splitY+1)/map.map_size.y) * source_res.y).xyz)
               preview:fill(px * pratio,py * pratio,pratio,pratio,clr)
               --heightmap:fill(px * pratio,py * pratio,pratio,pratio,vectors.vec4(h,h,h,1))
               --prestruction:fill(px * pratio,py * pratio,pratio,pratio,vectors.vec4((cid-1)/128,h,0,1))
               local p = map:getPixel(px * pratio,py * pratio)
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
                  progress("Generating Map",(px+py)/pres)
                  prestruction:update()
                  if py > pres-1 then
                     px = 0
                     py = 0
                     pres = pres * 2
                     pratio = 128/pres
                     if pI <= 6 then pI = pI + 1 else
                        phase = 1
                     end
                  end
               end
            elseif phase == 1 and type(map.map_pos) ~= "nil" and not map.preview_mode then
               local p = map:getPixel(px,py)
               local block_id = p[1]
               local offset = p[2]
               height = height + offset
               local current_pos = vectors.vec3(px, height, py)
               table.insert(map.instruction,"/setblock "..map.map_pos.x + splitX * 128 + current_pos.x.." "..current_pos.y.." "..map.map_pos.y + current_pos.z.." "..map.colors[block_id].blk)
               last_block_id = block_id
               last_offset = offset
               py = py + 1
               progress("Generating Instructions",(px)/128)
               if py >= 128 then
                  py = 0
                  px = px + 1
                  height = 128
                  last_offset = 0
                  if px >= 128 then
                     phase = 0
                     splitX = splitX + 1
                     px = 0
                     py = 0
                     pI = 1
                     pres = 2
                     print("Generating section "..splitX.." "..splitY)
                     pratio = 128/pres
                     if splitX >= map.map_size.x then
                        splitY = splitY + 1
                        splitX = 0
                        if splitY >= map.map_size.y then
                           map.buisy = false
                           print("Finished pregenerating eveerything")
                        end
                     end
                  end
               end
            end
         end
      end
   end
end)
return map