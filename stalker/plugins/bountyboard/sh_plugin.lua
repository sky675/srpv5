local PLUGIN = PLUGIN
PLUGIN.name = "Bounty Board/Odd Jobs"
PLUGIN.author = "sky"
PLUGIN.desc = "a bounty board entity with randomly generated generic jobs that can be turned in"

local uniqueid = uniqueid or 0
PLUGIN.curJobs = PLUGIN.curJobs or {}

nut.util.include("sh_jobs.lua")
	--will lower this later, for now its this high becuz 1 job
nut.config.add("bbTime", 14400, "The length of the timer which causes the bounty board jobs to reset (in seconds)", nil, {
	form = "Int",
	data = {min = 600, max = 28800},
	category = "Bounty Board",
	callback = function(old, new)
		timer.Adjust("bbrefresh", new) --should work
	end
})
nut.config.add("bbMax", 2, "Max amount of jobs generated per refresh.", nil, {
	form = "Int",
	data = {min = 1, max = 12},
	category = "Bounty Board"
})

nut.command.add("bountyCustom", {
	syntax = "<int reward> [string customName]",
	adminOnly = true,
	desc = "allows to create a custom bounty for the dropped item you are looking at with specified reward",
	onRun = function(client, arguments)
		local tr = client:GetEyeTrace()
		if(!tr.Hit or !IsValid(tr.Entity) or tr.Entity:GetClass() != "nut_item") then return "not looking at item" end

		local item = tr.Entity.nutItemID
		local name = tr.Entity:getItemTable().name

		local reward = tonumber(arguments[1])
		if(!reward) then return "no reward specified" end
		
		local job = PLUGIN.jobTemps["custombounty"]

		local tbl = {
			["name"] = arguments[2] and table.concat(arguments, " ", 2) or Format(job.name, unpack(job.format(name, reward))),
			["unique"] = true,
			["type"] = "custombounty",
			["itemid"] = item,
			["reward"] = reward,
		}


 	end
})

if(SERVER) then
	--moved so i can manually restart it
	function PLUGIN:InitTimer()
		for i=1,nut.config.get("bbMax", 4) do
			self:GenerateJob()
		end
		timer.Create("bbrefresh", nut.config.get("bbTime", 3600), 0, function()
			if(#ents.FindByClass("sky_bb") == 0) then return end --no bountyboards spawned rn

			for k,v in pairs(self.curJobs) do
				if(!v.unique) then
					self.curJobs[k] = nil
				end
			end

			for i=1,nut.config.get("bbMax", 4) do
				self:GenerateJob()
			end
		end)
	end
	--idk i did this in the other one
	bb_loadedalready = bb_loadedalready or false
	function PLUGIN:InitializedConfig()
		if(bb_loadedalready) then
			return
		else
			bb_loadedalready = true
		end



		self:InitTimer()
	end
				--unique wont be deleted on refresh
	function PLUGIN:GenerateJob(type, unique)
		local job
		if(!type) then
			--only get random jobs, so can have ones generated from elsewhere
			local temps = {}
			for k,v in pairs(self.jobTemps) do
				if(!v.unique) then
					temps[k] = v
				end
			end

			job, type = table.Random(temps)
		else
			job = self.jobTemps[type]
		end
		if(!job) then 
			nut.log.addRaw("Bounty board job tried to be created with type of "..type..", which doesnt exist in the job templates!")
			return
		end

		uniqueid = uniqueid+1
		local merge = job.generate()
		self.curJobs[uniqueid] = {
			name = Format(job.name, unpack(job.format(merge) or {})),
			["unique"] = unique,
			["type"] = type,
		}
		self.curJobs[uniqueid] = table.Merge(self.curJobs[uniqueid], merge)


	end

	function PLUGIN:ForceJob(jobtbl)
		uniqueid = uniqueid+1
		self.curJobs[uniqueid] = jobtbl
	end


	netstream.Hook("bbTurnIn", function(client, jobid)
		--check if they meet requirements for the job, 
		if(!PLUGIN.curJobs[jobid]) then
			client:notify("This job no longer exists!", 3)
			return
		end
		local job = PLUGIN.curJobs[jobid]
		if(PLUGIN.jobTemps[job.type].onTurnIn(client, job)) then
			--finish it and give them rewards,
			PLUGIN.jobTemps[job.type].giveReward(client, job)
			PLUGIN.curJobs[jobid] = nil
		else
			client:notify("You do not meet the requirements for this job's completion!", 3)
			--return --eh refresh anyway?
		end
		--and then reload the board same way as V
		local jobs = {}
		for k,v in pairs(PLUGIN.curJobs) do
			jobs[k] = {
				name = v.name,
				type = v.type
			}
		end
	
		netstream.Start(client, "bbReloadBoard", jobs, timer.TimeLeft("bbrefresh"))
	end)

	netstream.Hook("bbGetJobs", function(client)
		local jobs = {}
		for k,v in pairs(PLUGIN.curJobs) do
			jobs[k] = {
				name = v.name,
				type = v.type
			}
		end
	
		netstream.Start(client, "bbReloadBoard", jobs, timer.TimeLeft("bbrefresh"))
	end)

	function PLUGIN:LoadJobBoard(client)
		local jobs = {}
		for k,v in pairs(self.curJobs) do
			jobs[k] = {
				name = v.name,
				type = v.type
			}
		end

		netstream.Start(client, "bbLoadBoard", jobs, timer.TimeLeft("bbrefresh"))
	end
else--gonna need derma zzzzzz
	local timeDone = timeDone or nil
	jobUI = jobUI or nil

									--job list, time til refresh
	netstream.Hook("bbLoadBoard", function(jobs, timeTil)
		CreateJobUI(jobs, timeTil)
	end)
	netstream.Hook("bbReloadBoard", function(jobs, timeTil)
		if(jobUI == nil||!IsValid(jobUI)) then return end --if its gone dont do this

		timeDone = CurTime()+timeTil --reset
		LoadJobs(jobs)
	end)

	function CreateJobUI(jobs, timeTil)
		timeDone = CurTime()+timeTil

		local base = vgui.Create("DFrame")
		jobUI = base
		base:SetSize(ScrW()/3, ScrH()/2)
		base:SetTitle("")
		base:SetDraggable(true)
		base:MakePopup()
		base:SetKeyboardInputEnabled(false)
		base:Center()
		base:DockPadding(0, 0, 0, 0)

		local timeCount = base:Add("DLabel")
		timeCount:SetFont("nutSmallFont")
		timeCount:SetSize(base:GetWide()/2, 24)
		timeCount:SetTextColor(Color(255,255,255))
		timeCount:Dock(TOP)

		--have a visual countdown, when it reaches 0 reload the job ui
		timer.Create("jobuitimer", 1, 0, function()
			if(jobUI == nil||!IsValid(jobUI)) then timer.Remove("jobuitimer") return end
			local curtime = CurTime()

			if(timeDone > curtime) then
				--not done yet, countdown
				timeCount:SetText(" Time Until Refresh: "..string.NiceTime(math.Round(timeDone-curtime)))
			else
				--done, reload jobs
				timeCount:SetText(" Refreshing...")
				netstream.Start("bbGetJobs")
			end
		end)

		local holder = base:Add("DScrollPanel")
		base.holder = holder
		holder:Dock(FILL)

		LoadJobs(jobs)
	end

	function LoadJobs(jobs)
		local self = jobUI.holder
		if(!self) then --just in case
			jobUI.holder = jobUI:Add("DScrollPanel")
			jobUI.holder:Dock(FILL)
			self = jobUI.holder
		end
		self.ins = self.ins or {}
		for k,v in pairs(self.ins) do
			v:Remove()
		end

		for k,v in pairs(jobs) do
			local butt = self:Add("DButton")
			self.ins[k] = butt
			butt:SetText(v.name )--idk more?
			butt:SetTooltip(PLUGIN.jobTemps[v.type].desc) --?
			butt:SetSize(jobUI.holder:GetWide(), 64)
			butt:Dock(TOP)
			butt:DockMargin(0,0,0,5)
			butt.DoClick = function()
				netstream.Start("bbTurnIn", k)
			end
		end
	end
end