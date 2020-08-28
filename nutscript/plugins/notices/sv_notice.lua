
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


do
	local playerMeta = FindMetaTable("Player")

	-- Utility function to notify a player.
	function playerMeta:notify(message, level)
		nut.util.notify(message, self, level)
	end

end