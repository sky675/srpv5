local PANEL = {}
local quiztbl = {
	{
		question = "Can you type in English and properly, using capital letters and full stops?",
		answers = {
			"yes i can",
			"Yes, I can.",
			"Что за чертовщина?"
		},
		correct = 2,
	},
	{
		question = "You do not need items to roleplay, do you understand?",
		answers = {
			"Yes.",
			"MUH SCRIPTZ",
		},
		correct = 1,
	},
	{
		question = "What do you think serious roleplaying is about?",
		answers = {
			"Collecting items and upgrades.",
			"Developing your character.",
		},
		correct = 2,
	},
	{
		question = "What universe is this roleplaying game set in?",
		answers = {
			"Real Life.",
			"STALKER.",
			"Half-Life.",
		},
		correct = 2,
	},
	{
		question = "Do you understand that roleplaying is slow paced and relaxed?",
		answers = {
			"BANG BANG",
			"Yes.",
		},
		correct = 2,
	},
	{
		question = "Which answer is an example of a proper name?",
		answers = {
			"baddie182",
			"Kanye West",
			"John",
			"Michael Gray"
		},
		correct = 4,
	},
	{
		question = "Which answer is an example of a proper physical description?",
		answers = {
			"An average sized rookie in an anorak with black hair",
			"born in chechnya and is really good with guns",
			"has a REALLY HOT GIRLFRIEND and favorite games are gmod and gta 5"

		},
		correct = 1,
	},
	{
		question = "Do you understand that cheating is not tolerated on this server, and that if we\n suspect you are cheating and/or hacking you will be permanently banned?",
		answers = {
			"Yes.",
			"muh esp thoooooo",
		},
		correct = 1,
	},
	{
		question = "Do you understand that this is a serious RP server, and any kind of trolling\n will get you banned?",
		answers = {
			"Yes.",
			"i play darkrp",
		},
		correct = 1,
	},
}

    function PANEL:Init()
        if(IsValid(nut.gui.quiz)) then
            nut.gui.quiz:Remove()
        end

        nut.gui.quiz = self
        local prog = {}
        local done = false

        self:SetSize(ScrW(), ScrH())
		self:SetZPos(999) 
		self:MakePopup()

        self.logo = self:Add("DImage")
        self.logo:SetMaterial(Material("sky/stalkerlogo.png"))
        self.logo:SetTall(128)
        self.logo:SetWide(402)
        self.logo:CenterHorizontal()
        self.logo:SetY(10)

        self.main = self:Add("DScrollPanel")
        self.main:SetSize(ScrW()*0.6, ScrH()*0.6)
        self.main:SetY(145)
        self.main:CenterHorizontal()
		self.main:SetZPos(1001)
		
		for k,v in ipairs(quiztbl) do
			local id = "q"..tostring(k)
			self.main[id.."Label"] = vgui.Create("DLabel", self.main)
			self.main[id.."Label"]:SetText(v.question)
            self.main[id.."Label"]:SetFont("nutCharSubTitleFont")
			self.main[id.."Label"]:SizeToContents()
            self.main[id.."Label"]:SetTextColor(Color(255,255,255,255))
			self.main[id.."Label"]:Dock(TOP)
            self.main[id.."Label"]:DockMargin(0,15,0,5)
            
			self.main[id] = vgui.Create("DComboBox", self.main)
            self.main[id]:SetFont("stalkerTraitLabelFont")
            self.main[id]:SetTextColor(Color(255,255,255,255))
			self.main[id]:SetSize(160, 30)
			self.main[id]:Dock(TOP)
			self.main[id]:SetValue("Select an answer")
			for _,text in ipairs(v.answers) do
				self.main[id]:AddChoice(text)
			end
			self.main[id].OnSelect = function(panel, index, value)
				if(index == v.correct) then
					prog[k] = true
				else
					prog[k] = false
				end
			end
            local panelStyle = self.main[id]

            panelStyle.Paint = function(panelStyle, w, h)
                nut.util.drawBlur(panelStyle)
                surface.SetDrawColor(0, 0, 0, 100)
                surface.DrawRect(0, 0, w, h)
            end
		end


        self.main.sub = vgui.Create("DButton", self.main)
        self.main.sub:SetDrawBackground(false)
        self.main.sub:SetTextColor(Color(255,255,255))
        self.main.sub:SetText("Submit ✔")
        self.main.sub:SetFont("stalkerCharButtonFont")
        self.main.sub:SetSize(200, 30)
        self.main.sub:Dock(TOP)
        self.main.sub:DockMargin(0,15,0,0)
        self.main.sub.DoClick = function()
            if(!done and #prog == #quiztbl) then
                for k,v in pairs(prog) do
                    if (!v) then
                        done = false
                        break
                    end
                    
                    done = true
                end
            end

            if(done) then
                --gui.OpenURL("http://forums.roleplayresurgence.com")
                --net.Start("SendQuizDone")
                --net.WriteBool(true)
                --net.SendToServer()
                self:Remove()
            else
                --print("kick")
                net.Start("SendnewQuizFail")
                net.WriteTable(prog)
                net.SendToServer()
            end
        end
	end
	
	function PANEL:OnRemove()
		if (IsValid(nut.gui.char)) then
			nut.gui.char:playMusic()
		end
	end

	function PANEL:Paint(w, h)
        surface.SetMaterial(Material("sky/menu.png"))
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
    end

vgui.Register("nut_newquiz", PANEL, "EditablePanel")