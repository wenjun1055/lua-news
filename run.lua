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
app_config = require("config")
ngx.print(app_config.host)



-- local request_method = ngx.var.request_method
-- ngx.print(request_method)