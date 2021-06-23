local PANEL = {}

PANEL.tabLabel = "Map"


local MAP_TEXTURES = {
    ["rp_crossroads_v1b"] = {
        texture = Material("sky/pda_maps/crossroads.png"),
        sizeX = 1920,
        sizeY = 1080
    }
}

--[[
    This is still very much a wip.

    No documentation because this is very scuffed right now, just uh don't mess with it. I'll come back and refactor a lot of it.

    TODO:
        -Map POI locations
        -User created locations
        -Sending locations to other PDAs
        -Maybe player location (its a toughie)
-]]


local contW, contH = ScrW()*0.289, ScrH()*0.498
local scrollspeed = 0.03
local isClicking = false
local xOffset, yOffset = 0, 0
local curX, curY = 0, 0 
local lastX, lastY
local mapText = Material("sky/pda_maps/nomap.png")
local mapOrgW, mapOrgH = 1920, 1080
local curMap = game.GetMap()

local mapCoordScale
local scaledMapCoordOffset
local zoomOffset
local mapW, mapH = mapOrgW, mapOrgH
local startMouseX, startMouseY
local mapIcons = {}

function PANEL:Init()

    for k, v in pairs(MAP_TEXTURES) do
        if curMap == k then
            mapText = v.texture
            mapOrgW, mapOrgH = v.sizeX, v.sizeY
        end
    end

    lastX, lastY = -mapOrgW*0.45, -mapOrgW*0.2
    
    zoomOffset = 1
    mapW, mapH = mapOrgW, mapOrgH

    self.map = self:Add("DPanel")
    self.map:SetSize(contW, contH)

    
end

function PANEL:OnMouseWheeled(delta)
    --[[
        Delta is only ever 1 or -1
            1 means zooming in
           -1 means zooming out
    --]]
    local oldzoom = zoomOffset
    local oldMapW, oldMapH = mapW, mapH

    zoomOffset = zoomOffset + (scrollspeed*delta)
    if (mapOrgH*zoomOffset > mapOrgH or mapOrgH*zoomOffset < contH) then
        zoomOffset = oldzoom
    end
    mapW, mapH = math.Clamp(mapOrgW*zoomOffset, contW, mapOrgW), math.Clamp(mapOrgH*zoomOffset, contW*0.5625 , mapOrgW)
    
    lastX = math.Clamp((lastX+((oldMapW - mapW)*0.5)), (contW- mapW), 0 )
    lastY = math.Clamp((lastY+((oldMapH - mapH)*0.5)), (contH- mapH), 0 )
end


function PANEL:Paint(w, h)
    -- mapIcons = {
    --     ["iconexample"] = {
    --         locx = 100,
    --         locy = 100,
    --         icon = Material("sky/pda_maps/player.png"),
    --         w = 19,
    --         h = 19,
    --         color = Color(255,255,255,255)
    --     }
    -- }

    --print(mapIcons["player"].loc.x .. ", " .. mapIcons["player"].loc.y)



    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(mapText)

    --gui.MouseX() gui.MouseY()
    if (isClicking) then

        local xOffsetOld, yOffsetOld = xOffset, yOffset

        xOffset = startMouseX - gui.MouseX()
        yOffset = startMouseY - gui.MouseY()

        if (lastX - xOffset != math.Clamp(lastX - xOffset, (contW- mapW), 0)) then
            xOffset = xOffsetOld
        end

        if (lastY - yOffset != math.Clamp(lastY - yOffset, (contH - mapH), 0)) then
            yOffset = yOffsetOld
        end

    end
    
    surface.DrawTexturedRect(math.Clamp(lastX - xOffset, (contW- mapW), 0), math.Clamp(lastY - yOffset, (contH - mapH), 0), mapW, mapH)

    mapCoordScale = mapOrgW/mapW
    local mapPosX, mapPosY = lastX - xOffset, lastY - yOffset
    --[[
        Map Start:
            X: -13640

        Map End:
            X: 13455

        Distance of 27,095

        image map is width of ~960

        roughly a scale of .0354

        get absolute value of x (if positive, double it)
        
        scale to .0354
        add offset for map image
        ????
        cash money
    --]]

    -- for _,v in pairs(mapIcons) do
    --     surface.SetDrawColor(v.color)
    --     surface.SetMaterial(v.icon)

    --     local iconX, iconY = (v.locx + mapPosX), (v.locy + mapPosY)
    --     surface.DrawTexturedRect(iconX, iconY, v.w, v.h)
    -- end

end

function PANEL:onDisplay()
    self.map:SetMouseInputEnabled(true)

    self.map.OnMousePressed = function(map, mcode)
       isClicking = true
       startMouseX, startMouseY = gui.MouseX(), gui.MouseY()
       self.map:MouseCapture(true)
       self.map:SetCursor("hand")
    end

    self.map.OnMouseReleased = function(map, mcode)
        isClicking = false
        self.map:SetCursor("arrow")
        self.map:MouseCapture(false)
        lastX, lastY = lastX - xOffset, lastY - yOffset
        xOffset, yOffset = 0, 0
     end

    zoomOffset = 1
end

function PANEL:onHide()

end

vgui.Register("pdaMap", PANEL, "stalkerPdaTab")
