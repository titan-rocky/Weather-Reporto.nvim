-- Define a function to fetch information from a URLs
--
local fetchdata = require("weather.functions")
--local nerdicons = require("weather.devicons")
local math = require("math")

-- struct defaults
-- city : string
-- country : string
-- celsius : bool
-- displaycityname  : bool
--
--
-- struct contenot
-- condition : string
-- temp

local defaults = { 
	latitude = "84.2044",
	longitude = "41.3220",
	celsius = false,
}

local content = {}

function content.setup(opts)
	opts = opts or {}
	for k, v in pairs(defaults) do
		if opts[k] == nil then
			opts[k] = v
		end
	end

	content.feed = fetchdata(opts.latitude, opts.longitude)
        local mg = function (x) return string.format("%s",x) end
	local arg = content.feed
	if arg.temp~=nil and arg.temp ~= " " then

                arg.celtemp = math.floor(tonumber(arg.temp))
		arg.temp = math.floor((9 / 5) * (tonumber(arg.temp)))+ 32


		-- if celsius is true , it will concatenate celsius temp , else farenheit temp --
		content.strfeed = ((opts.celsius and mg(arg.celtemp)) or mg(arg.temp)) .. ((opts.celsius and "°C ") or "°F ") .. arg.condition
		content.kfeed = tostring(arg.temp + 241) .. "K " .. arg.condition

	else
		content.feed = {
			celtemp = "#E3",
			temp = "#E3",
		}
		content.kfeed = "#E3"
		content.strfeed = "#E3"
	end
end


return content
