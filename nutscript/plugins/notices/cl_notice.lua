-- List of notice panels.
nut.notices = nut.notices or {}

net.Receive("nutNotify", function()
	nut.util.notify(net.ReadString(), net.ReadInt(4))
end)

-- Creates a translated notification.
function nut.util.notifyLocalizedL(message, level, ...)
	nut.util.notify(L(message, ...), level)
end

-- Receives a notification from the server.
net.Receive("nutNotifyLL", function()
	local level = net.ReadInt(4)
	local message = net.ReadString()
	local length = net.ReadUInt(8)

	if (length == 0) then
		return nut.util.notifyLocalizedL(message, level)
	end

	local args = {}
	for i = 1, length do
		args[i] = net.ReadString()
	end

	nut.util.notifyLocalizedL(message, level, unpack(args))
end)

-- Move all notices to their proper positions.
local function OrganizeNotices()
	for k, v in ipairs(nut.notices) do
		v:MoveTo(
			ScrW() - (v:GetWide() + 4),
			(k - 1) * (v:GetTall() + 4) + 4,
			0.15,
			(k / #nut.notices) * 0.25
		)
	end
end

-- Create a notification panel.

function nut.util.notify(message, level)
	--Levels go 1(Green), 2(Yellow), 3(Red)
	local notice = vgui.Create("nutNotice")
	local i = table.insert(nut.notices, notice)
	
	-- Set up information for the notice.
	notice:SetText(" "..message .. "  ")
	notice:SetPos(ScrW(), (i - 1) * (notice:GetTall() + 4) + 4)
	notice:SizeToContentsX()
	notice:SetWide(notice:GetWide() + 30)
	if(level == nil) then
		level = 1
	end
	notice:SetLevel(level)

	notice.start = CurTime() + 0.25
	notice.endTime = CurTime() + 7.75

	-- Add the notice we made to the list.
	OrganizeNotices()

	-- Show the notification in the console.
	MsgC(Color(0, 255, 255), message.."\n")

	-- Once the notice appears, make a sound and message.
	timer.Simple(0.15, function()
		LocalPlayer():EmitSound("interface/notif.ogg")
	end)

	-- After the notice has displayed for 7.5 seconds, remove it.
	timer.Simple(7.75, function()
		if (IsValid(notice)) then
			-- Search for the notice to remove.
			for k, v in ipairs(nut.notices) do
				if (v == notice) then
					-- Move the notice off the screen.
					notice:MoveTo(ScrW(), notice.y, 0.15, 0.1, nil, function()
						notice:Remove()
					end)

					-- Remove the notice from the list and move other notices.
					table.remove(nut.notices, k)
					OrganizeNotices()

					break
				end
			end
		end
	end)
end
