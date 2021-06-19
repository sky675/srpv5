local PANEL = {}

PANEL.tabLabel = "Announcements"

--[[
    Because I know you don't like to get rid of stuff you've made, I saw you commented this out previously and decided to add the option for it 
--]]

function PANEL:DataLookup()
    --This function clearly ran when the announcements were to be displayed, but I couldn't find it anywhere, so I'll just keep this here.
end

function PANEL:Init()
    local announcementURL = nut.config.get("pdaAnnouncementsURL")
	self.announcements = self:Add("DHTML")

end

function PANEL:onDisplay()
    self.announcements:OpenURL(announcementURL)

    --a little trick i learned so that you can use the garrysmod scrollbar instead of the HTML scrollbar :) 
        --just whatever html page you create, wrap everything in a div with the id "content"
    self.announcements.OnDocumentReady = function(announcements)
        announcements:AddFunction("returnvar", "gettall", function(str)
            announcements:SetTall(tonumber(str) + 10)
        end)
        announcements:RunJavascript(
[[var elmnt = document.getElementById("content");
var y = elmnt.scrollHeight;
returnvar.gettall(y)]])
    end
	self:DataLookup()
end

vgui.Register("pdaAnnouncements", PANEL, "stalkerPdaTab")
