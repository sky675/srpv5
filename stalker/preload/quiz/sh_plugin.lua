local PLUGIN = PLUGIN
PLUGIN.name = "Quiz"
PLUGIN.author = "sky"
PLUGIN.desc = "wip redone quiz"

hook.Add("PluginShouldLoad", "disableintro", function(id)
	if(id == "nsintro") then return false end
end)

if(SERVER) then
	util.AddNetworkString("SendnewQuizFail")
	util.AddNetworkString("newquizfinish")

	net.Receive("SendnewQuizFail", function(_, ply)
		local prog = net.ReadTable()
		ply:setNutData("intro") --uh reset yeah
		if(#prog == 0) then
			RunConsoleCommand("ev","kick",ply:Name(),"Failed the quiz -- also answered 0 questions anyway. are you okay?")
			return
		end

		local count = 0
		local wrong = ""
	
		local tabl = ""
		for k,v in pairs(prog or {}) do
			if(!v) then 
				count = count + 1 
				wrong = wrong.." "..k
			end
			tabl = tabl..tostring(k)..":"..tostring(v).." - "
		end
		
		local qu = count == 1 and "question" or "questions"

		RunConsoleCommand("ev","kick",ply:Name(),"Failed the quiz -- "..count.." "..qu.." wrong:"..wrong)--incorrect questions: "..count)

		nut.log.addRaw(ply:Name().." was kicked for failing the quiz, they answered "..tostring(#prog).." questions, and this is the answer table: "..tabl, FLAG_DANGER)
	end)

	net.Receive("newquizfinish", function(_, ply)
		ply:setNutData("intro", true)
	end)	

else --client
	hook.Add("CreateQuiz", "quizintro", function()
		return vgui.Create("nut_newquiz")
	end)

	hook.Add("NutScriptLoaded", "newquiz", function()
		net.Start("newquizfinish")
		net.SendToServer()
	end)
end