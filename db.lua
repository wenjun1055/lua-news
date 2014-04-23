local Db = {}

mysql = require("mysql")
	
function Db.get_news_list_by_program(program, page_no, page_size)
	local db, err = mysql:new()
    
    if not db then
		ngx.say("failed to instantiate mysql: ", err)
		return
	end

	db:set_timeout(1000)

	local ok, err, errno, sqlstate = db:connect{
                    host = "127.0.0.1",
                    port = 3306,
                    database = "lua-news",
                    user = "root",
                    password = "root",
                    max_packet_size = 1024 * 1024 }

    if not ok then
		ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
		return
	end

	local start = (page_no - 1) * page_size
	local sql = "select * from `news` where `program`='"
				..program..
				"' order by `id` DESC limit "
				..start..","..page_size
	res, err, errno, sqlstate = db:query(sql)

	if not res then
		ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
		return
	end

	-- local cjson = require "cjson"
	-- ngx.say(cjson.encode(res))
	-- ngx.print(res[1]["title"])
	return res

end

return Db