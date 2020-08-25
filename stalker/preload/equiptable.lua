local PLUGIN = PLUGIN
PLUGIN.name = "equiptable util"
PLUGIN.author = "sky"
PLUGIN.desc = "utility funcs for keeping track of equips"
EQTBL = true

local maxes = { --maxes of each
	["art"] = 1,
	["weapon"] = 2
}

function equipTblGet(char, type, default)
	local tbl = char:getData("equiptbl", {})
	return tbl[type] or default
end
function equipTblCount(char, type, default)
	local tbl = char:getData("equiptbl", {})
	return (tbl[type] and #tbl[type]) or default
end
--max without extras
function equipTblIsMax(char, type)
	if(maxes[type]) then
		local cnt = equipTblCount(char, type, 0)
		if(cnt >= (maxes[type])) then
			return true
		end
	end
	return false
end
if(SERVER) then
	function equipTblAdd(char, type, item)
		if(maxes[type]) then
			local cnt = equipTblCount(char, type, 0)
			if(cnt >= (maxes[type]+char:getData("ex"..type, 0))) then
				return false, "Cannot equip more items of this type"
			end
		end
		
		local tbl = char:getData("equiptbl", {})
		if(!tbl[type]) then
			tbl[type] = {}
		end
		tbl[type][#tbl[type]+1] = item.id
		char:setData("equiptbl", tbl)
		return true
	end
	function equipTblRem(char, type, item)
		if(isnumber(item)) then --index supp just in case
			print("remove index supp not done yet")
			--todo
			return false, "this shouldnt appear"
		end

		local tbl = char:getData("equiptbl", {})
		if(!tbl[type]) then
			return false, "No item found"
		end
		local search = table.KeyFromValue(tbl[type], item.id)
		if(!search) then
			return false, "No item found"
		end
		table.remove(tbl[type], search)
		char:setData("equiptbl", tbl)
		return true
	end
end