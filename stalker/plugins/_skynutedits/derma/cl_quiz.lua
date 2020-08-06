local PANEL = {}

    function PANEL:Init()
        if(IsValid(nut.gui.quiz)) then
            nut.gui.quiz:Remove()
        end

        nut.gui.quiz = self
        local prog = {}
        local done = false

        self:SetSize(ScrW(), ScrH())
		self:SetZPos(999) 

        self.main = self:Add("DScrollPanel")
        self.main:SetSize(ScrW()*0.4, ScrH()*0.6)
        self.main:Center()
        self.main:SetZPos(1001)

        --hardcoded questions becuz fuck u
        --Can you type in english and properly, using capital letters and full stops?
        --yes i can
        --Yes, I can.
        --Что за чертовщина?
        --2
        self.main.q1Label = vgui.Create("DLabel", self.main)
        self.main.q1Label:SetText("Can you type in English and properly, using capital letters and full stops?")
        self.main.q1Label:SizeToContents()
        self.main.q1Label:Dock(TOP)

        self.main.q1 = vgui.Create("DComboBox", self.main)
        self.main.q1:SetSize(160, 30)
        self.main.q1:Dock(TOP)
        self.main.q1:SetValue("")
        self.main.q1:AddChoice("yes i can")
        self.main.q1:AddChoice("Yes, I can.")
        self.main.q1:AddChoice("Что за чертовщина?")
        self.main.q1.OnSelect = function(panel, index, value)
            if(value == "Yes, I can.") then
                prog[1] = true
            else
                prog[1] = false
            end
        end

        --You do not need items to roleplay, do you understand?
        --Yes.
        --MUH SCRIPTZ
        --1
        self.main.q2Label = vgui.Create("DLabel", self.main)
        self.main.q2Label:SetText("You do not need items to roleplay, do you understand?")
        self.main.q2Label:SizeToContents()
        self.main.q2Label:Dock(TOP)

        self.main.q2 = vgui.Create("DComboBox", self.main)
        self.main.q2:SetSize(160, 30)
        self.main.q2:Dock(TOP)
        self.main.q2:SetValue("")
        self.main.q2:AddChoice("Yes.")
        self.main.q2:AddChoice("MUH SCRIPTZ")
        self.main.q2.OnSelect = function(panel, index, value)
            if(value == "Yes.") then
                prog[2] = true
            else
                prog[2] = false
            end
        end

        --What do you think serious roleplaying is about?
        --Collecting items and upgrades.
        --Developing your character.
        --2
        self.main.q3Label = vgui.Create("DLabel", self.main)
        self.main.q3Label:SetText("What do you think serious roleplaying is about?")
        self.main.q3Label:SizeToContents()
        self.main.q3Label:Dock(TOP)

        self.main.q3 = vgui.Create("DComboBox", self.main)
        self.main.q3:SetSize(160, 30)
        self.main.q3:Dock(TOP)
        self.main.q3:SetValue("")
        self.main.q3:AddChoice("Collecting items and upgrades.")
        self.main.q3:AddChoice("Developing your character.")
        self.main.q3.OnSelect = function(panel, index, value)
            if(value == "Developing your character.") then
                prog[3] = true
            else
                prog[3] = false
            end
        end
        
        --What universe is this roleplaying game set in?
        --Real Life.
        --S.T.A.L.K.E.R.
        --Half-Life 2.
        --2
        self.main.q4Label = vgui.Create("DLabel", self.main)
        self.main.q4Label:SetText("What universe is this roleplaying game set in?")
        self.main.q4Label:SizeToContents()
        self.main.q4Label:Dock(TOP)

        self.main.q4 = vgui.Create("DComboBox", self.main)
        self.main.q4:SetSize(160, 30)
        self.main.q4:Dock(TOP)
        self.main.q4:SetValue("")
        self.main.q4:AddChoice("Real Life.")
        self.main.q4:AddChoice("Metro 2033.")
        self.main.q4:AddChoice("S.T.A.L.K.E.R.")
        self.main.q4.OnSelect = function(panel, index, value)
            if(value == "Metro 2033.") then
                prog[4] = true
            else
                prog[4] = false
            end
        end
        
        --Do you understand that roleplaying is slow paced and relaxed?
        --BANG BANG
        --Yes.
        --2
        self.main.q5Label = vgui.Create("DLabel", self.main)
        self.main.q5Label:SetText("Do you understand that roleplaying is slow paced and relaxed?")
        self.main.q5Label:SizeToContents()
        self.main.q5Label:Dock(TOP)

        self.main.q5 = vgui.Create("DComboBox", self.main)
        self.main.q5:SetSize(160, 30)
        self.main.q5:Dock(TOP)
        self.main.q5:SetValue("")
        self.main.q5:AddChoice("BANG BANG")
        self.main.q5:AddChoice("Yes.")
        self.main.q5.OnSelect = function(panel, index, value)
            if(value == "Yes.") then
                prog[5] = true
            else
                prog[5] = false
            end
        end

        --Will you read the rules that will open in your browser after you finish this quiz? (alternatively available at the Rules button on the character menu and directly at http://forums.roleplayresurgence.com/showthread.php?tid=5)
        --no
        --fuck ur rules
        --Yes, I promise.
        --3
        self.main.q6Label = vgui.Create("DLabel", self.main)
        self.main.q6Label:SetText("Which answer is an example of a proper name?")
        self.main.q6Label:SizeToContents()
        self.main.q6Label:Dock(TOP)

        self.main.q6 = vgui.Create("DComboBox", self.main)
        self.main.q6:SetSize(160, 30)
        self.main.q6:Dock(TOP)
        self.main.q6:SetValue("")
        self.main.q6:AddChoice("gren103")
        self.main.q6:AddChoice("destroyer")
        self.main.q6:AddChoice("John")
        self.main.q6:AddChoice("Pavel Popov")
        self.main.q6:AddChoice("Brad Pitt")
        self.main.q6.OnSelect = function(panel, index, value)
            if(value == "Pavel Popov") then
                prog[6] = true
            else
                prog[6] = false
            end
        end

        self.main.q7Label = vgui.Create("DLabel", self.main)
        self.main.q7Label:SetText("Which answer is an example of a proper physical description?")
        self.main.q7Label:SizeToContents()
        self.main.q7Label:Dock(TOP)

        self.main.q7 = vgui.Create("DComboBox", self.main)
        self.main.q7:SetSize(160, 30)
        self.main.q7:Dock(TOP)
        self.main.q7:SetValue("")
        self.main.q7:AddChoice("An average sized citizen of the Metro with black hair")
        self.main.q7:AddChoice("born in chechnya and is really good with guns")
        self.main.q7:AddChoice("has a REALLY HOT GIRLFRIEND and favorite games are gmod and gta 5")
        self.main.q7.OnSelect = function(panel, index, value)
            if(value == "An average sized citizen of the Metro with black hair") then
                prog[7] = true
            else
                prog[7] = false
            end
        end

        --Do you understand that cheating is not tolerated on this server, and that if we suspect you are cheating you will be banned?
        --Yes.
        --muh esp thoooooo
        --2
        self.main.q8Label = vgui.Create("DLabel", self.main)
        self.main.q8Label:SetText("Do you understand that cheating is not tolerated on this server, and that if we suspect you are cheating and/or hacking you will be permanently banned?")
        self.main.q8Label:SizeToContents()
        self.main.q8Label:Dock(TOP)

        self.main.q8 = vgui.Create("DComboBox", self.main)
        self.main.q8:SetSize(160, 30)
        self.main.q8:Dock(TOP)
        self.main.q8:SetValue("")
        self.main.q8:AddChoice("Yes.")
        self.main.q8:AddChoice("muh esp thoooooo")
        self.main.q8.OnSelect = function(panel, index, value)
            if(value == "Yes.") then
                prog[8] = true
            else
                prog[8] = false
            end
        end
        
        self.main.q9Label = vgui.Create("DLabel", self.main)
        self.main.q9Label:SetText("Do you understand that this is a serious RP server, and any kind of trolling will get you banned?")
        self.main.q9Label:SizeToContents()
        self.main.q9Label:Dock(TOP)

        self.main.q9 = vgui.Create("DComboBox", self.main)
        self.main.q9:SetSize(160, 30)
        self.main.q9:Dock(TOP)
        self.main.q9:SetValue("")
        self.main.q9:AddChoice("Yes.")
        self.main.q9:AddChoice("i play darkrp")
        self.main.q9.OnSelect = function(panel, index, value)
            if(value == "Yes.") then
                prog[9] = true
            else
                prog[9] = false
            end
        end

        --make the submit button not only check all the answers, 
        --but also if theyre right, open the rules in the browser 
        --http://forums.roleplayresurgence.com/showthread.php?tid=5

        self.main.sub = vgui.Create("DButton", self.main)
        self.main.sub:SetText("Submit")
        self.main.sub:SetSize(200, 30)
        self.main.sub:Dock(TOP)
        self.main.sub.DoClick = function()
            if(!done and #prog == 9) then
                for k,v in pairs(prog) do
                    if (!v) then
                        done = false
                        break
                    end
                    
                    done = true
                end
            end

            if(done) then
                gui.OpenURL("http://forums.roleplayresurgence.com")
                net.Start("SendQuizDone")
                net.WriteBool(true)
                net.SendToServer()
                self:Remove()
            else
                --print("kick")
                net.Start("SendQuizFail")
                net.WriteTable(prog)
                net.SendToServer()
            end
        end
    end

	function PANEL:Paint(w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, w, h)
    end

vgui.Register("nutQuiz", PANEL, "EditablePanel")