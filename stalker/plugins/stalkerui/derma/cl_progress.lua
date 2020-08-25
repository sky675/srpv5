
--bar images: 2x16
if (CLIENT) then
	local barEmpty = "sky/prog/empty/"
	local barFill = "sky/prog/fill/"
	--For UI elements, w should be the width measured on the actual UI images. this function will autoscale 
	--																it to that, unless do autoScale = false
	-- THIS WILL NOT AUTOSCALE POSITION, SO MAKE SURE YOU DO THE FANCY EQUATION FOR POSITIONING FOR ARGS x, y!!!!!!!
	function stalkerProgress(x, y, w, fillColor, percentFill, autoScale, manualH)

		local barSizeX = 0
		local barSizeY = 0
		local totalWidth = 0

		if( !autoScale ) then
			--print("Auto scale is off for progressbar: " .. id)
			totalWidth = w
			local newRatio = 16/manualH
			--local barSizeX, barSizeY = (2*(newRatio)), manualH			
			barSizeX = math.ceil((2*(newRatio)))
			barSizeY = math.ceil(barSizeX*8)
		else
			--print("Autoscale is on")
			totalWidth = w*(invh/invTextureH)
			barSizeX = math.ceil((2*(invw/invTextureW)))
			barSizeY = math.ceil(barSizeX*8)
		end

		--local totalWidth = w*(invh/invTextureH)

		local barPosX, barPosY = x, y
		local isNegative = false

		if (percentFill < 0) then
			isNegative = true
			percentFill = math.abs(percentFill)
			fillColor = (Color(255, 0, 0, 155))
		end

		local barCount = math.floor(totalWidth/(barSizeX + barSizeX))
		local fillBarCount = math.ceil(barCount*percentFill)
		--print("====PROG DEBUG: barCount = " .. barCount)
		--print("====PROG DEBUG: fillBarCount = " .. fillBarCount)

		--draw empty bars that will be filled
		local x = 0
		local barTextMax = 4
		local currentBarPosX = barPosX
		local prevTexture = 0
		
		for i=1, barCount do
			local k = 1
			--print("painting bar: " .. i)
			math.randomseed(1234)
			while k == 1 do
				x = math.random(barTextMax)
				if (x >= prevTexture+1) then
					k = 2
				elseif (x <= prevTexture-1) then
					k = 2
				end
			end
			
			local thisBarTexture = (barEmpty .. x .. ".png")

			prevTexture = x
			if (i <= fillBarCount ) then
				surface.SetDrawColor(fillColor)
			else
				surface.SetDrawColor(255,255,255,255)
			end
			
			surface.SetMaterial(Material(thisBarTexture))
			surface.DrawTexturedRect(currentBarPosX, barPosY, barSizeX, barSizeY)	
			--print("bar texture: "..thisBarTexture)

			local debugY = barSizeY
			local debugX = barSizeX
			--print("bar size: x" .. debugX .. " y" .. debugY)
			currentBarPosX = currentBarPosX + ((barSizeX*2))

		end
			
	end

	function stalkerCountdown(x, y, w, fillColor, percentFill, autoScale, manualH)

		local barSizeX = 0
		local barSizeY = 0
		local totalWidth = 0

		if( !autoScale ) then
			--print("Auto scale is off for progressbar: " .. id)
			totalWidth = w
			local newRatio = 16/manualH
			--local barSizeX, barSizeY = (2*(newRatio)), manualH			
			barSizeX = math.ceil((2*(newRatio)))
			barSizeY = math.ceil(barSizeX*8)
		else
			--print("Autoscale is on")
			totalWidth = w*(invh/invTextureH)
			barSizeX = math.ceil((2*(invw/invTextureW)))
			barSizeY = math.ceil(barSizeX*8)
		end

		--local totalWidth = w*(invh/invTextureH)

		local barPosX, barPosY = x, y
		local isNegative = false

		if (percentFill < 0) then
			isNegative = true
			percentFill = math.abs(percentFill)
			fillColor = (Color(255, 0, 0, 155))
		end

		local barCount = math.floor(totalWidth/(barSizeX + barSizeX))
		local fillBarCount = math.ceil(barCount*percentFill)
		--print("====PROG DEBUG: barCount = " .. barCount)
		--print("====PROG DEBUG: fillBarCount = " .. fillBarCount)

		--draw empty bars that will be filled
		local x = 0
		local barTextMax = 4
		local currentBarPosX = barPosX
		local prevTexture = 0
		
		for i=1, barCount do
			local k = 1
			--print("painting bar: " .. i)
			math.randomseed(1234)
			while k == 1 do
				x = math.random(barTextMax)
				if (x >= prevTexture+1) then
					k = 2
				elseif (x <= prevTexture-1) then
					k = 2
				end
			end
			
			local thisBarTexture = (barEmpty .. x .. ".png")

			prevTexture = x
			if (i <= fillBarCount ) then
				surface.SetDrawColor(255,255,255,255)
			else
				surface.SetDrawColor(fillColor)
			end
			
			surface.SetMaterial(Material(thisBarTexture))
			surface.DrawTexturedRect(currentBarPosX, barPosY, barSizeX, barSizeY)	
			--print("bar texture: "..thisBarTexture)

			local debugY = barSizeY
			local debugX = barSizeX
			--print("bar size: x" .. debugX .. " y" .. debugY)
			currentBarPosX = currentBarPosX + ((barSizeX*2))

		end
			
	end



	function stalkerProgressEndCoord(x, y, w, autoScale, manualH)

		if( !autoScale ) then
			--print("Auto scale is off for progressbar: " .. id)
			totalWidth = w
			local newRatio = 16/manualH
			--local barSizeX, barSizeY = (2*(newRatio)), manualH			
			barSizeX = math.ceil((2*(newRatio)))
			barSizeY = math.ceil(barSizeX*8)
		else
			--print("Autoscale is on")
			totalWidth = w*(invh/invTextureH)
			barSizeX = math.ceil((2*(invw/invTextureW)))
			barSizeY = math.ceil(barSizeX*8)
		end
		local barPosX, barPosY = x, y

		local barCount = math.floor(totalWidth/(barSizeX + barSizeX))
		local currentBarPosX = barPosX
		
		for i=1, barCount do
			math.randomseed(1234)
			if (i != barCount) then
				currentBarPosX = currentBarPosX + ((barSizeX*2))
			end
		end
		return (currentBarPosX + barSizeX)
	end

	function stalkerProgressHeight()
		local barSizeX = math.ceil((2*(invw/invTextureW)))
		local barSizeY = math.ceil(barSizeX*8)
		--print("===RETURNED: " .. barSizeY)

		return barSizeY + barSizeX
		
	end
end



