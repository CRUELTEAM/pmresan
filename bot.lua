package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'
URL = require('socket.url')
JSON = require('dkjson')
HTTPS = require('ssl.https')
dofile('utilities.lua')
----config----
local bot_api_key = "403021340:AAGZ2E-uWGLKfvWiSpyth9r_Yo1x2VPOQeU" --BOT TOKEN تو کن ربات خود را در اینجا قرار دهید
local You = 199957800  --ID ADMIN ایدی خود را اینجا قرار دهید
local BASE_URL = "https://api.telegram.org/bot"..bot_api_key
local BASE_FOLDER = ""
local start = [[ ]]

-------

----utilites----
local help = [[
➖➖➖➖➖➖➖➖➖➖➖
*commands:*`for admin`
`/ban` ✴️
بن کردن یک شخص
`/unban` ✴️
ان بن کردن یک شخص
`/users` ✴️
تعداد کاربران
`/broadcast` ✴️
شروع پیام همگانی
`/unbroadcast` ✴️
پایان ارسال پیام همگانی
`/start` ✴️
شروع
`/id` ✴️
ایدی
➖➖➖➖➖➖➖➖➖➖➖
M.KH @cruel0098
]]--
-------

----utilites----

function is_admin(msg)-- Check if user is admin or not
  local var = false
  local admins = {You}
  for k,v in pairs(admins) do
    if msg.from.id == v then
      var = true
    end
  end
  return var
end
function is_add(msg)-- Check if user is ADD or not
  local var = false
  local add = add.id
  for k,v in pairs(add) do
    if msg.from.id == v then
      var = true
    end
  end
  return var
end
function is_ban(msg)-- Check if user is ban or not
  local var = false
  local add = ban.id
  for k,v in pairs(add) do
    if msg.from.id == v then
      var = true
    end
  end
  return var
end
function sendRequest(url)
  local dat, res = HTTPS.request(url)
  local tab = JSON.decode(dat)

  if res ~= 200 then
    return false, res
  end

  if not tab.ok then
    return false, tab.description
  end

  return tab

end
function getMe()
    local url = BASE_URL .. '/getMe'
  return sendRequest(url)
end
function getUpdates(offset)

  local url = BASE_URL .. '/getUpdates?timeout=20'

  if offset then

    url = url .. '&offset=' .. offset

  end

  return sendRequest(url)

end
function sendSticker(chat_id, sticker, reply_to_message_id)

	local url = BASE_URL .. '/sendSticker'

	local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "sticker=@' .. sticker .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	io.popen(curl_command):read("*all")
	return end
function sendPhoto(chat_id, photo, caption, reply_to_message_id)

	local url = BASE_URL .. '/sendPhoto'

	local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "photo=@' .. photo .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end

	if caption then
		curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
	end

	io.popen(curl_command):read("*all")
	return end
function forwardMessage(chat_id, from_chat_id, message_id)

	local url = BASE_URL .. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id

	return sendRequest(url)

end
function sendMessage(chat_id, text, disable_web_page_preview, reply_to_message_id, use_markdown)

	local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)

	if disable_web_page_preview == true then
		url = url .. '&disable_web_page_preview=true'
	end

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end

	if use_markdown then
		url = url .. '&parse_mode=Markdown'
	end

	return sendRequest(url)

end
function sendDocument(chat_id, document, reply_to_message_id)

	local url = BASE_URL .. '/sendDocument'

	local curl_command = 'cd \''..BASE_FOLDER..currect_folder..'\' && curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "document=@' .. document .. '"'

	if reply_to_message_id then
		curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
	end
	io.popen(curl_command):read("*all")
	return

end
function download_to_file(url, file_name, file_path)
  print("url to download: "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  -- nil, code, headers, status
  local response = nil
    options.redirect = false
    response = {HTTPS.request(options)}
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then return nil end
  local file_path = BASE_FOLDER..currect_folder..file_name

  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
function sendPhotoID(chat_id, file_id, caption, reply_to_message_id, disable_notification)

	local url = BASE_URL .. '/sendPhoto?chat_id=' .. chat_id .. '&photo=' .. file_id

	if caption then
		url = url .. '&caption=' .. URL.escape(caption)
	end

	if reply_to_message_id then
		url = url .. '&reply_to_message_id=' .. reply_to_message_id
	end

	if disable_notification then
		url = url .. '&disable_notification=true'
	end

	return sendRequest(url)

end
function getUserProfilePhotos(user_id)
if user_id == nil then
return
else
local url = BASE_URL .. '/getUserProfilePhotos?user_id='..user_id
print(url)
return sendRequest(url)
end
end
function download_to_file(url, file_name, file_path)
  print("url to download: "..url)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  -- nil, code, headers, status
  local response = nil
    options.redirect = false
    response = {HTTPS.request(options)}
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then return nil end
  local file_path = file_name

  print("Saved to: "..file_path)

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
-------- @cruel0098 M.KH
function bot_run()
	bot = nil

	while not bot do -- Get bot info
		bot = getMe()
	end

	bot = bot.result
  if not add then
		add = load_data('mico.db')
	end
	if not ban then
		ban = load_data('ban.db')
	end
	local bot_info = "Username = @"..bot.username.."\nName = "..bot.first_name.."\nID = "..bot.id.." \n[jon the cruel channel](https://telegram.me/joinchat/Cz0GaD5yj9_VLaNXOOg3ag)"

	print(bot_info)
	for k,v in pairs(add.id) do
  print(k.." :"..v)
  end

	last_update = last_update or 0

 currect_folder = ""

 is_running = true
	math.randomseed(os.time())
	math.random()


	last_cron = last_cron or os.date('%M', os.time()) -- the time of the last cron job,
	is_started = true -- and whether or not the bot should be running.
  add.id = add.id or {} --TABLE FUCKERRRRRRRRRRRRRRRRRRRRRRRRRRR
  ban.id = ban.id or {}
  add.broadcast = add.broadcast or {} --
end

function msg_processor(msg)

	if msg.date < os.time() - 5 then -- Ignore old msgs
		return
    end

if msg.text:match('/p (.*)')then
local matches = {string.match(msg.text,('/p (.*)'))}
local input = get_word(matches[1])
local lid = resolve_username(input)
local phl =  getUserProfilePhotos(tonumber(lid))
local file = phl.result.photos[1][1].file_id
print(file)
local url = BASE_URL .. '/getFile?file_id='..file
	local res = HTTPS.request(url)
 local jres = JSON.decode(res)
local caption = "his id :- "..lid

sendPhotoID(msg.chat.id,file,caption)
elseif msg.reply_to_message and msg.text == '/p' then
local lid = msg.reply_to_message.from.id
local phl =  getUserProfilePhotos(tonumber(lid))
local file = phl.result.photos[1][1].file_id
print(file)
local url = BASE_URL .. '/getFile?file_id='..file
	local res = HTTPS.request(url)
 local jres = JSON.decode(res)
local caption = "his id :- "..lid

sendPhotoID(msg.chat.id,file,caption)

elseif msg.text == '/p' then
local ph = getUserProfilePhotos(msg.from.id)
local file = ph.result.photos[1][1].file_id
local url = BASE_URL .. '/getFile?file_id='..file
	local res = HTTPS.request(url)
	local jres = JSON.decode(res)

if msg.from.username ~= nil then
msg.from.username = '@'..msg.from.username
elseif msg.from.username == nil then
msg.from.username = "you don't have"
end
local caption = 'your nam :- '..msg.from.first_name..'\nyour id :-'..msg.from.id..'\nyour username :- '..msg.from.username

	sendPhotoID(msg.chat.id,file,caption)
elseif msg.text:match('/id (.*)$') then
local matches = {string.match(msg.text,('/id (.*)'))}
		local input = get_word(matches[1])
  id = resolve_username(input)
sendMessage(msg.chat.id,id)
elseif msg.text:match('/w (.*) (.*)') then
local matches = {string.match(msg.text,('/w (.*) (.*)'))}
local lt = matches[1]:gsub("_"," ")
local lr = matches[2]:gsub("_"," ")
add.talk[lt]= lr
elseif msg.text and add.talk[msg.text] ~= nil then
local ion = add.talk[msg.text]
local out = ion:gsub("_"," ")
sendMessage(msg.chat.id,out,true,msg.message_id)
elseif msg.from.username then
		add.usernames[msg.from.username:lower()] = msg.from.id

end
end
function msg_processor(msg)


if msg.text == "/start" and not is_add(msg) then
 	table.insert(add.id,msg.from.id)
 	print("adding.....")
 	 	local user = ""
if msg.from.username == nil then
user = bot.username
else
user = msg.from.username
end
local text = "سلام ["..msg.from.first_name.."](www.telegram.me/"..user..")\n\n[ربات خود را بسازید](http://opizo.com/3AGyRT)"
sendMessage(msg.chat.id,text.."\n"..start,true,false,true)
elseif msg.text == "/start" and is_add(msg) then
 	print(#add.id)
 	local user = ""
if msg.from.username == nil then
user = bot.username
else
user = msg.from.username
end
local text = "سلام ["..msg.from.first_name.."](www.telegram.me/"..user..")\n\n[ربات خود را بسازید](http://opizo.com/3AGyRT)"
sendMessage(msg.chat.id,text.."\n"..start,true,false,true)
elseif is_admin(msg) and msg.text == "/users" then
 	local r = tostring(#add.id)

 	local t = string.gsub(r," ","")
sendMessage(You,t,true,false,true)
end
if msg.text == '/help' then
sendMessage(msg.chat.id,help,true,false,true)
end
if is_ban(msg) then return end
if msg.date < os.time() - 5 then -- Ignore old msgs
		return
end
if msg.text == "/unbroadcast" then
  add.broadcast = "broadcast"
  save_data('mico.db', add)
  sendMessage(msg.chat.id,"*I will not broadcast any more*",true,false,true)
end
if msg.text ~= "/broadcast" and  add.broadcast ~= "broadcast" then
if is_admin(msg) then
if msg.text and msg.text ~= "/unbroadcast" then
for k,v in pairs(add.id) do
sendMessage(v,msg.text,true,false,true)
end

elseif not msg.text then
for k,v in pairs(add.id) do
forwardMessage(v,You,msg.message_id)
end
end
end
elseif msg.text ~= "/" then
if is_admin(msg) and msg.reply_to_message and msg.reply_to_message.forward_from ~= nil and msg.text == "/ban" then
table.insert(ban.id,msg.reply_to_message.forward_from.id)
sendMessage(msg.reply_to_message.forward_from.id,"*YOU HAVE BEEN BANNED*",true,false,true)
elseif is_admin(msg) and msg.reply_to_message and msg.reply_to_message.forward_from ~= nil and msg.text == "/unban" then
for k, v in pairs(ban["id"]) do
if ( v == msg.reply_to_message.forward_from.id ) then
table.remove(ban["id"], k)
end
end
sendMessage(msg.reply_to_message.forward_from.id,"*YOU HAVE BEEN unBANNED*",true,false,true)
elseif is_admin(msg) and msg.reply_to_message and msg.text == "/id" then
 if msg.reply_to_message.forward_from.last_name ~= nil then
 	 last_name = msg.reply_to_message.forward_from.last_name
 else
 	 last_name = ""
 end
