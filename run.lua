--[[
	入口文件
]]--
ngx.header.content_type    = "text/plain";
ngx.header.server_protocol = "HTTP/3.1" 
ngx.header.blessing 	   = "Son Of Bitch" 

--获取当前项目的工作目录--
local app_path = ngx.var.root_path
--设置package path--
if not (package.path:find(app_path)) then
	package.path = package.path .. ";" .. app_path .. "/?.lua;;"
end
--设置package cpath--
if not (package.cpath:find(app_path)) then
	package.cpath = package.cpath .. ";" .. app_path .. "/?.so;;"
end

--装载配置--
local app_config = require("config")
-- ngx.print(app_config.host)

--获取请求的原始uri和请求方式--
local request_method = ngx.var.request_method
local request_uri 	 = ngx.var.request_uri

--截取request_uri分析出连接中有用的部分--
local uri_prefix_len  = string.len(app_config.uri_prefix)
local request_uri_len = string.len(request_uri)

local params = {
		["program"] = "all", 
		["page"]    = "program",
		["pageno"]  = 1
	}

if request_uri_len > 5 then
	--截取真实请求串--
	local real_request_uri = string.sub(request_uri, uri_prefix_len + 1)

	--加载functions--
	local functions = require("functions")	

	params = nil

	params = functions.seprate_uri(real_request_uri)
end

--加载数据库类--
local db = require("db")

--根据参数进行不同页面的渲染工作--
if "article" == params["page"] then
	--文章页面--
	local article_id = params["article_id"]
	ngx.print(article_id)

else 
	local news_list = db.get_news_list_by_program(params["program"], params["pageno"], app_config.page_size)
	--TODO 渲染工作--

end