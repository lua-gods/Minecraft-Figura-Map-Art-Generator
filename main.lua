if not host:isHost() then return end
local panel = require("libraries.panel")
models.hud:setParentType("HUD")
models.world:setParentType("WORLD")
panel:setPage(require("pages.main menu"))