local PLUGIN = PLUGIN
PLUGIN.name = "Stalker Intro"
PLUGIN.author = "🧔 Nate"
PLUGIN.desc = "Video intro."

nut.config.add("introEnabled", true, "Whether or not intro is enabled.", nil, {
	category = PLUGIN.name
})

nut.config.add("playIntroOnlyOnce", true, "Whether the intro, if enabled, should play every time, or only on first join", nil, {
	category = PLUGIN.name
})

if (SERVER) then


	netstream.Hook("ipgive", function(ply)

		--API KEYS: to hide at some point okay this is only visible for testing
		local ipstackKey = "59eed43df4e669a579000f78efbaefa0"
		local translateKey = "AIzaSyAWPanUx0shuUsGDSKjI2nDKfSV8hQ4_RM"
	
		local disclaimerText = "This server is english only."

		local ipResults = {}

		local ipaddress = ply:IPAddress() --regex to remove port
		if (ipaddress == "loopback") then
			ipaddress = "2.135.255.255"
		end

		local ipstackURL = "http://api.ipstack.com/"..ipaddress.."?access_key="..ipstackKey.."&fields=country_code,location.languages&format=1"

		http.Fetch(ipstackURL,
			function(body, length, headers, code)   -- on success :)
				ipResults = util.JSONToTable(body)
				--PrintTable(ipResults)
				local langlist = {}
				for k, v in ipairs(ipResults.location.languages) do
					if k <= 3 then
						table.insert(langlist, k, v.code)
					end
				end

				local toplang = ipResults.location.languages[1].code

				--now translate lol
				if (toplang != "en") then
					local disclist = {} --list of all translations
					local translateURL = "https://translation.googleapis.com/language/translate/v2?key="..translateKey


					for k, v in ipairs(langlist) do
						print("k: " .. k)
						--print(v)
						http.Post(translateURL,
							{	--parameters
								q = disclaimerText,
								source = "en",
								target = v, --v for auto, set string for forced target language
								format = "text"
							},
								-- onSuccess function
							function( body, length, headers, code )
								--print( "~~~Done translating!" )
								PrintTable(util.JSONToTable(body))							
								table.insert(disclist, k, util.JSONToTable(body).data.translations[1].translatedText)
	
								

							end,
							-- onFailure function
							function( message )
								print("~~~failure translating!")
								print( message )
							end
							)
					end
					timer.Simple(1, function()
						netstream.Start(ply, "langDisclaimer", disclist)
					end)
					

					--PrintTable(disclist)
				end

			end,
			function(message)					    -- on fail :(
				local fetchError = message
				print("--## IP Nationality failed: " .. fetchError)
			end,
			{		   		  						-- headers
				["content-type"] = "application/json"
			}
		)
		

	end)



end

if (CLIENT) then
	function PLUGIN:CreateIntroduction()
		if (nut.config.get("introEnabled")) then
			return vgui.Create("nutIntro")
		end
	end
end
