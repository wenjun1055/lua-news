local Functions = {}

--[[
	分解uri
]]--
function Functions.seprate_uri(request_uri)
	-- 去掉前面的/ --
	local position = string.find(request_uri, "/", 1)
	if 1 == position then 
		request_uri = string.sub(request_uri, 2)
	end

	-- 去掉后面的/ --
	local position = string.find(request_uri, "/", -1)
	if position == string.len(request_uri) then
		request_uri = string.sub(request_uri, 1, position - 1)
	end

	-- 长度为0 --
	if 0 == string.len(request_uri) then
		return nil
	end

	-- 分解uri --
	local parameters = Functions.string_split(request_uri, '/')
	-- 分解后参数个数 --
	local parameters_num = table.maxn(parameters)
	-- 判断参数个数，参数要求成对出现，除开第一个决定页面的参数 --
	if 0 == parameters_num % 2 then
		table.remove(parameters, parameters_num)
		parameters_num = parameters_num - 1
	end

	local result = {}

	for k, v in pairs(parameters) do
		if 1 == k then
			result["page"] = v
		end

		if 0 == k % 2 then
			result[v] = parameters[k+1]
		end
	end
	
	return result
end

--[[
	字符串分割，类似php的explode
]]--
function Functions.string_split(orig_string, delimiter)
	local result = {}
	local from = 1
	local delim_from, delim_to = string.find(orig_string, delimiter, from)

	while delim_from do
		table.insert(result, string.sub(orig_string, from, delim_from - 1))
		from = delim_to + 1
		delim_from, delim_to = string.find(orig_string, delimiter, from)
	end

	table.insert(result, string.sub(orig_string, from))

	return result
end



return Functions