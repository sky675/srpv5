
hook.Add("EntityFireBullets", "SharpenWhenShotNear", function(ent, bul)
	
	if SERVER then
	
		function ApplySuppressionEffect(bhit, atk)
			for _,v in pairs(ents.FindInSphere(bhit, 70)) do
				if v:IsPlayer() and v:Alive() and v != atk then
					v:SetNWInt("SharpenAMT", math.Clamp(v:GetNWInt("SharpenAMT"), 0, 2) + 0.1)
					sound.Play("weapons/fx/rics/ric" .. math.random(1,5) .. ".wav", bhit, 75, 100, 1)
					timer.Remove(v:Name() .. "sharpenreset")
					hook.Run("OnSuppression", v, atk)
					timer.Create(v:Name() .. "sharpenreset", 2, 1, function()
						for i=1,(v:GetNWInt("SharpenAMT") / 0.05) + 1 do
							timer.Simple(0.1 * i, function()
								v:SetNWInt("SharpenAMT", math.Clamp(v:GetNWInt("SharpenAMT") - 0.1, 0, 100000))
							end)
						end
						if(IsValid(v) and v:GetMoveType() != MOVETYPE_NOCLIP) then
							v:EmitSound("player/suit_sprint.wav")
						end
					end) --end timer function
				end --end alive test
			end --end for
		end -- end function
	
		function bul:Callback(at, tr, dm)
			ApplySuppressionEffect(tr:GetDamagePosition(), tr:GetAttacker())
		end --what a load of ass
		
	end
end)

hook.Add("RenderScreenspaceEffects", "ApplySuppression", function()

	DrawSharpen(5, LocalPlayer():GetNWInt("SharpenAMT"))
	
end)

hook.Add("PlayerInitialSpawn", "SetUpSharpenNWInt", function(ply)

	ply:SetNWInt("SharpenAMT", 0)

end)

hook.Add("PlayerDeath", "RemoveSharpenOnDeath", function(ply, i, a)

	ply:SetNWInt("SharpenAMT", 0)

end)