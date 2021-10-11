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

    //local HTTP = CHTTP
    //local logURL = nut.config.get("discordWebsocketURL")
    local limit = 5
    local reset = 0


    //nothing entirely helpful, but we do requrie chttp
    local use_chttp = pcall(require, "chttp")
    if use_chttp then
        print("CHTTP working...")
    else
       print("CHTTP not working erugh!") 
    end

    local function SendDiscordMessage(embed, sendurl)
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
            CHTTP({
                method = "POST",
                url = sendurl, 
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
    hook.Add("NeedDiscordMsg", "SendWebhook", function(logType, logString) //default logging
        local data = {
            description = logString,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z"),
            color = LOGTYPE_TRANS[logType] or 0x818791
        }
        if(!LOGTYPE_EXCLUDE[logType]) then
            SendDiscordMessage(data, "https://discord.com/api/webhooks/896351302588710912/Q6Fi-sXhTgf5dZWk0xdq-6UxYsBmRMlFWONjrSqR8EPtNamdyj6529plg_s1EDdhZJ0h")    
        end
        
    end)

    hook.Add("EmbedDiscordMsg", "SendEmbed", function(embed) //custom embed log
        SendDiscordMessage(embed, "https://discord.com/api/webhooks/896351302588710912/Q6Fi-sXhTgf5dZWk0xdq-6UxYsBmRMlFWONjrSqR8EPtNamdyj6529plg_s1EDdhZJ0h")
    end)

    PDA_CHANNEL_COLOR_TRANS = {
        ["pdalocal"] = 0x64FF32,
        ["pdatrade"] = 0x73b4e6
    }
    PDA_CHANNEL_NAME_TRANS = {
        ["pdalocal"] = "[PDA-LOCAL]",
        ["pdatrade"] = "[PDA-TRADE]"
    }


    hook.Add("PlayerMessageSend", "PDAMessageHook", function(speaker, chatType, text, anonymous, receivers) //pda hook handle thing
        if chatType == "pdalocal" or chatType == "pdatrade" then
            local args = string.Split(text, "|")
            local handle = args[1]
            if(anonymous) then
                if(speaker:GetPDAMPF()) then
                    handle = "Metropolice Force"
                elseif(speaker:GetPDAMono()) then
                    handle = "invalid"
                end
            end
            local msg = args[2]
            local data = {
                title = handle,
                description ="<:pda:896973797285056512> "..PDA_CHANNEL_NAME_TRANS[chatType]..": ".. msg,
                timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z"),
                color = PDA_CHANNEL_COLOR_TRANS[chatType]
            }
            SendDiscordMessage(data, "https://discord.com/api/webhooks/896962355957760062/I8MY4A1c_U3SMQi5BAc39ytIalJ_B80xKKU1ntztF5xe0E85rx688HSHijwSlKtRYFRT")
        end
    end)

end
