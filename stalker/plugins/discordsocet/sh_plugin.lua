PLUGIN.name = "Big Brother"
PLUGIN.author = "Nate"
PLUGIN.desc = "He's always watching :)."

nut.config.add("discordLoggingEnabled", true, "Enable discord logging", nil, {
	category = PLUGIN.name
})
nut.config.add("discordAlertRoleID", "11111111111111111", "Discord Role ID to be alerted of certain events", nil, {
	category = PLUGIN.name
})
//https://discord.com/api/webhooks/896351302588710912/Q6Fi-sXhTgf5dZWk0xdq-6UxYsBmRMlFWONjrSqR8EPtNamdyj6529plg_s1EDdhZJ0h test webhook

if (SERVER) then
    local POST_MODES = {
        DISABLED = 0,
        ENABLED = 1
    }

    local HTTP = CHTTP
    local logURL = nut.config.get("discordWebsocketURL")
    local limit = 5
    local reset = 0


    //nothing entirely helpful, but we do requrie chttp
    local use_chttp = pcall(require, "chttp")
    if use_chttp then
        print("CHTTP working...")
    else
       print("CHTTP not working erugh!") 
    end

    local function SendDiscordMessage(embed, url)
        local now = os.time(os.date("!*t"))

        if limit == 0 and now < reset then
            local function tcb()
                SendDiscordMessage(embed)
            end

            timer.Simple(reset - now, tcb)
        end

        local function successCallback(status, body, headers)
            limit = headers["X-RateLimit-Remaining"]
            reset = headers["X-RateLimit-Reset"]
        end
        if(nut.config.get("discordLoggingEnabled")) then
            HTTP({
                method = "POST",
                url = "https://discord.com/api/webhooks/896351302588710912/Q6Fi-sXhTgf5dZWk0xdq-6UxYsBmRMlFWONjrSqR8EPtNamdyj6529plg_s1EDdhZJ0h", //hardcoded :)
                body = util.TableToJSON({
                    embeds={embed}
                }),
                type = "application/json",
                success = successCallback
            })
        end
    end
    LOGTYPE_TRANS = {
        command = 0xCC5500,
        playerConnected = 0x91d485,
        playerDisconnected = 0xed5fe4,
        configChange = 0xed5f80,
        chat = 0x73b4e6
    }
    LOGTYPE_EXCLUDE = {
        playerConnected = true
    }
    hook.Add("NeedDiscordMsg", "SendWebhook", function(logType, logString)
        local data = {
            description = logString,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z"),
            color = LOGTYPE_TRANS[logType] or 0x818791
        }
        if(!LOGTYPE_EXCLUDE[logType]) then
            SendDiscordMessage(data, logURL)    
        end
        
    end)

    hook.Add("EmbedDiscordMsg", "SendEmbed", function(embed)
        SendDiscordMessage(embed, logURL)
    end)



end
