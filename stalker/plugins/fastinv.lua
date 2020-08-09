PLUGIN.name = "Quick Menu (inventory)"
PLUGIN.author = "Black Tea/sky"
PLUGIN.desc = "Adds a quick menu (inventory) function. i only google translated the name/desc and changed a line to use an enum instead of hardcoded number"

	--name, soundlevel, pitch
--SOUND_INVENTORY_OPEN = {""}



if (CLIENT) then
	hook.Add("CanPlayerViewInventory", "inventorylock", function()
		return false
	end)
	netstream.Hook("quickMenu", function()
		if (quickInventoryPanel) then
			quickInventoryPanel:Remove()
		end

		local inventory = LocalPlayer():getChar():getInv()

		if (inventory) then
			if (SOUND_INVENTORY_OPEN) then
				LocalPlayer():EmitSound(unpack(SOUND_INVENTORY_OPEN))
			end

			quickInventoryPanel = inventory:show()
			quickInventoryPanel:ShowCloseButton(true)
			hook.Add("PostRenderVGUI", quickInventoryPanel, function()
				hook.Run("PostDrawInventory", quickInventoryPanel)
			end)
			
			function quickInventoryPanel:OnKeyCodePressed(key)
				if (key == KEY_F4) then
					quickInventoryPanel:Remove()
				end
			end
		end
	end)
else
	function PLUGIN:ShowSpare2(client)
		if (client:getChar() and !client:getNetVar("neardeath")) then
			netstream.Start(client, "quickMenu")
		end
	end
end