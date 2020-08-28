util.AddNetworkString("nutNotifyLL")

-- Sends a notification to a specified recipient.
function nut.util.notify(message, recipient, level)
	net.Start("nutNotify")
		net.WriteString(message)
		net.WriteInt(level or 1, 4)
	if (recipient == nil) then
		net.Broadcast()
	else
		net.Send(recipient)
	end
end

-- Sends a translated notification.
function nut.util.notifyLocalizedL(message, recipient, level, ...)
	local args = {...}

	-- Allow 2nd argument to just be part of the varargs.
	if (
		recipient ~= nil and
		type(recipient) ~= "table" and
		type(recipient) ~= "Player"
	) then
		table.insert(args, 1, recipient)
		recipient = nil
	end

	net.Start("nutNotifyLL")
		net.WriteInt(level or 1, 4)
		net.WriteString(message)
		net.WriteUInt(#args, 8)
		for i = 1, #args do
			net.WriteString(tostring(args[i]))
		end
	if (recipient == nil) then
		net.Broadcast()
	else
		net.Send(recipient)
	end
end

do
	local playerMeta = FindMetaTable("Player")

	-- Utility function to notify a player.
	function playerMeta:notify(message, level)
		nut.util.notify(message, self, level)
	end

	-- Utility function to notify a localized message to a player.
	function playerMeta:notifyLocalizedL(message, level, ...)
		nut.util.notifyLocalizedL(message, self, level, ...)
	end
end