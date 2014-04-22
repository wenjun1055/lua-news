local Db = {}

mysql = require("mysql")
	
function Db.get_news_list_by_program(program, limit = 10)
	local db, err = mysql:new()
    
    if not db then
		ngx.say("failed to instantiate mysql: ", err)
		return
	end
end

return Db