local Functions = {}

function Functions.seprate_uri(request_uri)
	if 0 == string.len(request_uri) then
		return 'index', nil
	end

	ngx.print(Functions.string_split(request_uri, '/'))

end

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