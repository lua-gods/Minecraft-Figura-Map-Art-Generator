local katt = require("libraries.KattEventsAPI")
local lib = {
   map_pos = nil,
   map_size = vectors.vec2(1,1),
   TARGET_MOVED = katt.newEvent(),
   TARGET_RESIZED = katt.newEvent(),
   colors = {
   {"7fb238","minecraft:grass_block"}, -- "Grass"
   {"f7e9a3","minecraft:birch_planks"}, -- "Sand"
   {"c7c7c7","minecraft:mushroom_stem"}, -- "Wool"
   {"ff0000","minecraft:redstone_block"}, -- "Fire"
   {"a0a0ff","minecraft:packed_ice"}, -- "Ice"
   {"a7a7a7","minecraft:iron_block"}, -- "Metal"
   {"007c00","minecraft:oak_leaves[persistent=true]"}, -- "Plant"
   {"ffffff","minecraft:snow_block"}, -- "Snow"
   {"a4a8b8","minecraft:clay"}, -- "Clay"
   {"976d4d","minecraft:brown_mushroom_block"}, -- "Dirt"
   {"707070","minecraft:stone"}, -- "Stone"
   {"4040ff",nil}, -- "Water"
   {"8f7748","minecraft:oak_planks"}, -- "Wood"
   {"fffcf5","minecraft:diorite"}, -- "Quartz"
   {"d87f33","minecraft:orange_wool"}, -- "Orange"
   {"b24cd8","minecraft:magenta_wool"}, -- "Magenta"
   {"6699d8","minecraft:light_blue_wool"}, -- "Light Blue"
   {"e5e533","minecraft:yellow_wool"}, -- "Yellow"
   {"7fcc19","minecraft:light_green_wool"}, -- "Light Green"
   {"f27fa5","minecraft:pink_wool"}, -- "Pink"
   {"4c4c4c","minecraft:gray_wool"}, -- "Gray"
   {"999999","minecraft:light_gray_wool"}, -- "Light Gray"
   {"4c7f99","minecraft:purple_wool"}, -- "Cyan"
   {"7f3fb2","minecraft:blue_wool"}, -- "Purple"
   {"334cb2","minecraft:brown_wool"}, -- "Blue"
   {"664c33","minecraft:green_wool"}, -- "Brown"
   {"667f33","minecraft:red_wool"}, -- "Green"
   {"993333","minecraft:black_wool"}, -- "Red"
   {"191919","minecraft:gold_block"}, -- "Black"
   {"faee4d","minecraft:diamond_block"}, -- "Gold"
   {"5cdbd5","minecraft:lapis_block"}, -- "Diamond"
   {"4a80ff","minecraft:emerald_block"}, -- "Lapiz"
   {"00d93a","minecraft:spruce_planks"}, -- "Emerald"
   {"815631","minecraft:nether_bricks"}, -- "Podzol"
   {"700200","minecraft:white_terracotta"}, -- "Nether"
   {"d1b1a1","minecraft:orange_terracotta"}, -- "Teracotta White"
   {"9f5224","minecraft:magenta_terracotta"}, -- "Teracotta Orange"
   {"95576c","minecraft:light_blue_terracotta"}, -- "Teracotta Magenta"
   {"706c8a","minecraft:yellow_terracotta"}, -- "Teracotta Light Blue"
   {"ba8524","minecraft:light_green_terracotta"}, -- "Teracotta Yellow"
   {"677535","minecraft:pink_terracotta"}, -- "Teracotta Light Green"
   {"a04d4e","minecraft:gray_terracotta"}, -- "Teracotta Pink"
   {"392923","minecraft:light_gray_terracotta"}, -- "Teracotta Gray"
   {"876b62","minecraft:cyan_terracotta"}, -- "Teracotta Light Gray"
   {"575c5c","minecraft:purple_terracotta"}, -- "Teracotta Cyan"
   {"7a4958","minecraft:blue_terracotta"}, -- "Teracotta Purple"
   {"4c3223","minecraft:brown_terracotta"}, -- "Teracotta Brown"
   {"4c522a","minecraft:green_terracotta"}, -- "Teracotta Green"
   {"8e3c2e","minecraft:red_terracotta"}, -- "Teracotta Red"
   {"251610","minecraft:black_terracotta"}, -- "Teracotta Black"
   {"bd3031","minecraft:crimson_nylium"}, -- "Crimson Nylium"
   {"943f61","minecraft:crimson_stem"}, -- "Crimson Stem"
   {"5c191d","minecraft:crimson_hyphae"}, -- "Crimson Hyphae"
   {"167e86","minecraft:warped_nylium"}, -- "Warped Nylium"
   {"3a8e8c","minecraft:warped_stem"}, -- "Warped Stem"
   {"562c3e","minecraft:warped_hyphae"}, -- "Warped Hyphae"
   {"14b485","minecraft:warped_wart_block"}, -- "Warped Wart Block"
   {"646464","minecraft:deepslate"}, -- "Deepslate"
   {"d8af93","minecraft:raw_iron_block"}, -- "Raw Iron"
   {"7fa796",nil}, -- "Glow Lichen"
   }
}

function lib:setMapPos(pos)
   local lmp = lib.map_pos
   local nmp = vectors.vec2((math.floor((pos.x-64)/128)+0.5)*128,(math.floor((pos.z-64)/128)+0.5)*128)
   if nmp ~= lmp then
      lib.map_pos = nmp
      lib.TARGET_MOVED:invoke(nmp)
   end
   return self
end

function lib:setMapSize(x,y)
   local new_size = vectors.vec2(x,y)
   if self.map_size ~= new_size then
      self.map_size = new_size
      lib.TARGET_RESIZED:invoke(x,y)
   end
   return self
end

return lib