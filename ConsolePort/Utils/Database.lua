local _, db = ...
---------------------------------------------------------------
-- Initialize database
---------------------------------------------------------------
LibStub('RelaTable')(db, _)

-- Provide a wrapper for default field data
function db:GetDefault(var)
	local varDefault = self.default[var]
	if (type(varDefault) == 'table' and varDefault.Get) then
		return varDefault:Get()
	end
	return varDefault
end

---------------------------------------------------------------
-- Extra table functions for various uses
---------------------------------------------------------------
-- This is a special iterator that returns a table in reverse order,
-- or by "intuitive" modifier order. E.g. Shift comes before Ctrl.
local mIndex = setmetatable({
	['']                = 1;
	['SHIFT-']          = 2;
	['CTRL-']           = 3;
	['ALT-']            = 4;
	['CTRL-SHIFT-']     = 5;
	['ALT-SHIFT-']      = 6;
	['ALT-CTRL-']       = 7;
	['ALT-CTRL-SHIFT-'] = 8;
}, {__index = function() return 9 end})

db('table/mpairs', function(t)
	return db.table.spairs(t, function(t, a, b)
		return mIndex[a] < mIndex[b];
	end)
end)

db('table/ripairs', ripairs or function(t)
	local function ripairsiter(t, index)
		index = index - 1;
		if index > 0 then
			return index, t[index];
		end
	end
	return ripairsiter, t, #t + 1;
end)

db('table/mixin', function(obj, ...)
	local scriptHandler = (type(obj.HasScript) == 'function')
	for i = 1, select('#', ...) do
		local mixin = select(i, ...)

		for k, v in pairs(mixin) do
			if scriptHandler and obj:HasScript(k) then
				if obj:GetScript(k) then
					obj:HookScript(k, v)
				else
					obj:SetScript(k, v)
				end
			end
			obj[k] = v
		end
	end
	return obj
end)

---------------------------------------------------------------
-- Plug-in access to addon data
---------------------------------------------------------------
function ConsolePort:DB(...)
	if select('#', ...) > 0 then
		return db(...)
	end
	return db
end