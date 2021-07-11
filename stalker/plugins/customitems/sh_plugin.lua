local PLUGIN = PLUGIN
PLUGIN.name = "Custom Flavor Items"
PLUGIN.author = "sky & Nate"
PLUGIN.desc = "Provides the option during character creation to spawn with a custom flavor option"

nut.config.add("allowFlavorItems", true, "Whether or not the option during character creation to create an item will show.", nil, {
	category = PLUGIN.name
})



FLAVOR_MODELS = {
    
    ["models/spec45as/stalker/quest/documents_6.mdl"] = {
        name = "Documents"
    },
    ["models/spec45as/stalker/quest/notes_document_case_2.mdl"] = {
        name = "Bound Journal"
    },
    ["models/spec45as/stalker/quest/notes_letter_1.mdl"] ={
        name = "Handwritten Letter"
    },
    ["models/spec45as/stalker/items/harmonica.mdl"] ={
        name = "Harmonica"
    },
    ["models/props_lab/frame002a.mdl"] ={
        name = "Group Photo"
    },
    ["models/maxofs2d/companion_doll.mdl"] ={
        name = "Doll"
    },
    ["models/wick/wrbstalker/anomaly/items/wick_book1.mdl"] ={
        name = "Dark Red Textbook"
    },
    ["models/wick/wrbstalker/anomaly/items/wick_book2.mdl"] ={
        name = "Black Textbook"
    },
    ["models/wick/wrbstalker/anomaly/items/wick_book3.mdl"] ={
        name = "Light Red Textbook"
    },
    ["models/wick/wrbstalker/anomaly/items/dez_drink_match0.mdl"] ={
        name = "Matchbook"
    },
    ["models/spec45as/stalker/quest/notes_photo_1.mdl"] = {
        name = "Photograph"
    },
}



function PLUGIN:OnCharCreated(client, char)
    local inventory = char:getInv()
    if (inventory) then	
        local flavorItemData = char:getData("flavoritem", {})
		if(flavorItemData.creating) then --give starting items from char creation
            PrintTable(flavorItemData)
            print(flavorItemData.name)
            print(flavorItemData.desc)
            print(flavorItemData.model)
            inventory:add("run_obj", 1, {
                customName = flavorItemData.name,
                customDesc = flavorItemData.desc,
                customMdl = flavorItemData.model,
            })
		end
    end

end

if (SERVER) then
    
else
    function PLUGIN:ConfigureCharacterCreationSteps(panel)
		panel:addStep(vgui.Create("nutCharacterFlavorItem"), 400)
	end
end