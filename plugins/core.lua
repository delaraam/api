--Begin Core.lua By #BeyondTeam -- edited by #poinshtan
local function getindex(t,id) 
	for i,v in pairs(t) do 
		if v == id then 
			return i 
		end 
	end 
	return nil 
end 

local function reload_plugins( ) 
	plugins = {} 
	load_plugins() 
end

--By @SoLiD021 -- edited by @poinshtan88
local function already_sudo(user_id)
	for k,v in pairs(_config.sudo_users) do
		if user_id == v then
			return k
		end
	end
	-- If not found
	return false
end

--By @SoLiD -- -- edited by @poinshtan88
local function sudolist(msg)
	local sudo_users = _config.sudo_users
	local text = "Sudo Users :\n"
	for i=1,#sudo_users do
		text = text..i.." - "..sudo_users[i].."\n"
	end
	return text
end

local function options(msg, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
     if not lang then
	 text = '_Welcome To_ *Group Option*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> Settings", callback_data="/settings:"..GP_id},
			{text = "> MuteList", callback_data="/mutelist:"..GP_id}
		},
		{
			{text = '> More ', callback_data = '/more:'..GP_id}
		},
		{
			{text= '> Back' ,callback_data = '/lang:'..GP_id}
		}				
	}
  elseif lang then
	 text = '_به تنظیمات کلی خوشآمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> تنظیمات", callback_data="/settings:"..GP_id},
			{text = "> لیست بیصدا", callback_data="/mutelist:"..GP_id}
		},
		{
			{text = '> قابلیت های بیشتر ', callback_data = '/more:'..GP_id}
		},
		{
			{text= '> بازگشت' ,callback_data = '/lang:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function moresetting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
local settings = data[tostring(GP_id)]["settings"]
   if not lang then
 text = '_Welcome To_ *More Settings*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '> Flood Sensitivity ', callback_data = 'BeyondTeam'}
		},
		{
			{text = "🔺", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="BeyondTeam"},
			{text = "🔻", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '> Character Sensitivity ', callback_data = 'BeyondTeam'}
		},
		{
			{text = "🔺", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="BeyondTeam"},
			{text = "🔻", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '> Flood Check Time ', callback_data = 'BeyondTeam'}
		},
		{
			{text = "🔺", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="BeyondTeam"},
			{text = "🔻", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '> Back ', callback_data = '/settings:'..GP_id}
		}				
	}
   elseif lang then
 text = '_به تنظیمات بیشتر خوش آمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '> حداکثر پیام های مکرر ', callback_data = 'BeyondTeam'}
		},
		{
			{text = "🔺", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="BeyondTeam"},
			{text = "🔻", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '> حداکثر حروف مجاز ', callback_data = 'BeyondTeam'}
		},
		{
			{text = "🔺", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="BeyondTeam"},
			{text = "🔻", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '> زمان بررسی پیام های مکرر ', callback_data = 'BeyondTeam'}
		},
		{
			{text = "🔺", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="BeyondTeam"},
			{text = "🔻", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = 'بـرگـشــت', callback_data = '/settings:'..GP_id}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

function setting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
	if data[tostring(GP_id)] and data[tostring(GP_id)]['settings'] then
		settings = data[tostring(GP_id)]['settings']
	else
		return
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = '❎'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = '❎'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = '❎'
	end
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = '❎'
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = '❎'
	end
	if settings.lock_mention then
		lock_mention = settings.lock_mention
	else
		lock_mention = '❎'
	end
		if settings.lock_edit then
		lock_edit = settings.lock_edit
	else
		lock_edit = '❎'
	end
		if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = '❎'
	end
	if settings.flood then
		lock_flood = settings.flood
	else
		lock_flood = '❎'
	end
	if settings.lock_markdown then
		lock_markdown = settings.lock_markdown
	else
		lock_markdown = '❎'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = '❎'
	end
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = '❎'
	end
	if settings.welcome then
		group_welcone = settings.welcome
	else
		group_welcone = '❎'
	end
    if not lang then
 text = '_Welcome To_ *Group Settings*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "Edit", callback_data='BeyondTeam'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id},
			{text = "Link", callback_data='BeyondTeam'}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "Tags", callback_data='BeyondTeam'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id},
			{text = "Join", callback_data='BeyondTeam'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "Flood", callback_data='BeyondTeam'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id},
			{text = "Spam", callback_data='BeyondTeam'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "Mention", callback_data='BeyondTeam'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id},
			{text = "Arabic", callback_data='BeyondTeam'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "Webpage", callback_data='BeyondTeam'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id},
			{text = "Markdown", callback_data='BeyondTeam'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "Pin", callback_data='BeyondTeam'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id},
			{text = "Bots", callback_data='BeyondTeam'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "> Group Welcome", callback_data='BeyondTeam'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '> More Settings ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '> Back ', callback_data = '/option:'..GP_id}
		}				
	}
     elseif lang then
 text = '_به تنظیمات گروه خوش آمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "ویرایش", callback_data='BeyondTeam'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id},
			{text = "لینک", callback_data='BeyondTeam'}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "تگ", callback_data='BeyondTeam'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id},
			{text = "ورود", callback_data='BeyondTeam'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "پیام مکرر", callback_data='BeyondTeam'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id},
			{text = "هرزنامه", callback_data='BeyondTeam'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "فراخوانی", callback_data='BeyondTeam'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id},
			{text = "عربی", callback_data='BeyondTeam'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "وب", callback_data='BeyondTeam'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id},
			{text = "فونت", callback_data='BeyondTeam'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "سنجاق", callback_data='BeyondTeam'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id},
			{text = "ربات ها", callback_data='BeyondTeam'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "> خوشآمد گویی", callback_data='BeyondTeam'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '> تنظیمات بیشتر ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '> بازگشت ', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function mutelists(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
    if data[tostring(GP_id)] and data[tostring(GP_id)]['mutes'] then
		mutes = data[tostring(GP_id)]['mutes']
	else
		return
	end
	if mutes.mute_all then
		mute_all = mutes.mute_all
	else
		mute_all = '❎'
	end
	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = '❎'
	end
   if mutes.mute_photo then
		mute_photo = mutes.mute_photo
	else
		mute_photo = '❎'
	end
	if mutes.mute_sticker then
		mute_sticker = mutes.mute_sticker
	else
		mute_sticker = '❎'
	end
	if mutes.mute_contact then
		mute_contact = mutes.mute_contact
	else
		mute_contact = '❎'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = '❎'
	end
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = '❎'
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = '❎'
	end
	if mutes.mute_keyboard then
		mute_keyboard = mutes.mute_keyboard
	else
		mute_keyboard = '❎'
	end
	if mutes.mute_forward then
		mute_forward = mutes.mute_forward
	else
		mute_forward = '❎'
	end
	if mutes.mute_location then
		mute_location = mutes.mute_location
	else
		mute_location = '❎'
	end
   if mutes.mute_document then
		mute_document = mutes.mute_document
	else
		mute_document = '❎'
	end
	if mutes.mute_voice then
		mute_voice = mutes.mute_voice
	else
		mute_voice = '❎'
	end
	if mutes.mute_audio then
		mute_audio = mutes.mute_audio
	else
		mute_audio = '❎'
	end
	if mutes.mute_video then
		mute_video = mutes.mute_video
	else
		mute_video = '❎'
	end
	if mutes.mute_tgservice then
		mute_tgservice = mutes.mute_tgservice
	else
		mute_tgservice = '❎'
	end
   if not lang then
	 text = '_Welcome To_ *Group Mutelist*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> Mute All", callback_data='BeyondTeam'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id}
		},
		{
			{text = "Gifs", callback_data='BeyondTeam'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id},
			{text = "Text", callback_data='BeyondTeam'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id}
		},
		{
			{text = "Inline", callback_data='BeyondTeam'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id},
			{text = "Game", callback_data='BeyondTeam'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id}
		},
		{
			{text = "Photo", callback_data='BeyondTeam'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id},
		        {text = "Video", callback_data='BeyondTeam'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id}
		},
		{
			{text = "Audio", callback_data='BeyondTeam'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id},
			{text = "Voice", callback_data='BeyondTeam'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id}
		},
		{
			{text = "Sticker", callback_data='BeyondTeam'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id},
			{text = "Contact", callback_data='BeyondTeam'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id}
		},
		{
			{text = "Forward", callback_data='BeyondTeam'}, 
			{text = mute_forward, callback_data="/muteforward:"..GP_id},
			{text = "Location", callback_data='BeyondTeam'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id}
		},
		{
			{text = "Document", callback_data='BeyondTeam'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id},
			{text = "TgService", callback_data='BeyondTeam'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id}
		},
	        {
			{text = "> Mute Keyboard", callback_data='BeyondTeam'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '> Back ', callback_data = '/option:'..GP_id}
		}				
	}
   elseif lang then
	 text = '_به لیست بیصدای گروه خوش آمدید_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> بیصدا همه", callback_data='BeyondTeam'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id}
		},
		{
			{text = "گیف", callback_data='BeyondTeam'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id},
			{text = "متن", callback_data='BeyondTeam'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id}
		},
		{
			{text = "اینلاین", callback_data='BeyondTeam'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id},
			{text = "بازی", callback_data='BeyondTeam'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id}
		},
		{
			{text = "عکس", callback_data='BeyondTeam'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id},
			{text = "فیلم", callback_data='BeyondTeam'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id}
		},
		{
			{text = "آهنگ", callback_data='BeyondTeam'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id},
			{text = "صدا", callback_data='BeyondTeam'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id}
		},
		{
			{text = "استیکر", callback_data='BeyondTeam'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id},
			{text = "مخاطب", callback_data='BeyondTeam'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id}
		},
		{
			{text = "نقل و قول", callback_data='BeyondTeam'}, 
			{text = mutes.mute_forward, callback_data="/muteforward:"..GP_id},
			{text = "موقعیت", callback_data='BeyondTeam'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id}
		},
		{
			{text = "فایل", callback_data='BeyondTeam'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id},
			{text = "خدمات تلگرام", callback_data='BeyondTeam'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id}
		},
		{
			{text = "> بیصدا کیبورد", callback_data='BeyondTeam'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '> بازگشت ', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
--------------Begin Msg Matches---------------
	if matches[1] == "sudolist" and is_sudo(msg) then
		return sudolist(msg)
	end
	if tonumber(msg.from.id) == sudo_id then
		if matches[1]:lower() == "setsudo" then
			if matches[2] and not msg.reply_to_message then
				local user_id = matches[2]
				if already_sudo(tonumber(user_id)) then
					return 'User '..user_id..' is already sudo users'
				else
					table.insert(_config.sudo_users, tonumber(user_id)) 
					print(user_id..' added to sudo users') 
					save_config() 
					reload_plugins(true) 
					return "User "..user_id.." added to sudo users" 
				end
		elseif not matches[2] and msg.reply_to_message then
			local user_id = msg.reply_to_message.from.id
			if already_sudo(tonumber(user_id)) then
				return 'User '..user_id..' is already sudo users'
			else
				table.insert(_config.sudo_users, tonumber(user_id)) 
				print(user_id..' added to sudo users') 
				save_config() 
				reload_plugins(true) 
				return "User "..user_id.." added to sudo users" 
			end
		end
	end
	if matches[1]:lower() == "remsudo" then
	if matches[2] and not msg.reply_to_message then
		local user_id = tonumber(matches[2]) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	elseif not matches[2] and msg.reply_to_message then
		local user_id = tonumber(msg.reply_to_message.from.id) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	end
	end
	end
--------------End Msg Matches---------------

--------------Begin Inline Query---------------
if msg.query and msg.query:match("-%d+") and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d+")
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = ' قـابـلیـت هـای ربـات ', callback_data = '/lang:'..chatid}
		},
		{
			{text= 'خــــروج' ,callback_data = '/exit:'..chatid}
		}					
	}
	send_inline(msg.id,'settings','Group Option','Tap Here','لطفا یکی از گزینه های زیر را انتخاب کنید',keyboard)
end
if msg.cb then
local hash = "gp_lang:"..matches[2]
local lang = redis:get(hash) 
	if matches[1] == '/lang' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    elseif not data[tostring(matches[2])] then
     if not lang then
		edit_inline(msg.message_id, "`Group Is Not Added`")
   elseif lang then
		edit_inline(msg.message_id, "_گروه به لیست مدیریتی ربات اضافه نشده_")
   end
	else
	local text = '`لطفا` *زبان* `را انتخاب کنید`'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> English", callback_data="/english:"..matches[2]},
			{text = '> فارسی ', callback_data = '/persian:'..matches[2]}
		},
		{
			{text= '> خــــروج' ,callback_data = '/exit:'..matches[2]}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
	end
end
	if matches[1] == '/english' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    redis:del(hash)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/persian' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    redis:set(hash, true)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/option' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
	options(msg, matches[2])
	end
end
if matches[1] == '/settings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutelist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/moresettings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		moresetting(msg, data, matches[2])
	end
end

          -- ####################### Settings ####################### --
if matches[1] == '/locklink' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
		if locklink == "❎" then
   if not lang then
			text = 'Link Has Been Locked'
   elseif lang then
			text = 'قفل لینک فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "✅"
			save_data(_config.moderation.data, data)
		elseif locklink == "✅" then
   if not lang then
			text = 'Link Has Been Unlocked'
   elseif lang then
			text = 'قفل لینک غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockedit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
		if lockedit == "❎" then
   if not lang then
			text = 'Edit Has Been Locked'
   elseif lang then
			text = 'قفل ویرایش فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "✅"
			save_data(_config.moderation.data, data)
		elseif lockedit == "✅" then
   if not lang then
			text = 'Edit Has Been Unlocked'
   elseif lang then
			text = 'قفل ویرایش غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktags' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_tag"]
		if chklock == "❎" then
   if not lang then
			text = 'Tags Has Been Locked'
   elseif lang then
			text = 'قفل تگ فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_tag"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Tags Has Been Unlocked'
   elseif lang then
			text = 'قفل تگ غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_tag"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockjoin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_join"]
		if chklock == "❎" then
   if not lang then
			text = 'Join Has Been Locked'
   elseif lang then
			text = 'قفل ورود فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_join"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Join Has Been Unlocked'
   elseif lang then
			text = 'قفل ورود غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_join"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockflood' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["flood"]
		if chklock == "❎" then
   if not lang then
			text = 'Flood Has Been Locked'
   elseif lang then
			text = 'قفل پیام های مکرر فعال شد'
    end
            data[tostring(matches[2])]["settings"]["flood"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Flood Has Been Unlocked'
   elseif lang then
			text = 'قفل پیام های مکرر غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["flood"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockspam' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_spam"]
		if chklock == "❎" then
   if not lang then
			text = 'Spam Has Been Locked'
   elseif lang then
			text = 'قفل هرزنامه فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_spam"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Spam Has Been Unlocked'
   elseif lang then
			text = 'قفل هرزنامه غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_spam"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmention' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_mention"]
		if chklock == "❎" then
   if not lang then
			text = 'Mention Has Been Locked'
   elseif lang then
			text = 'قفل فراخوانی فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_mention"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Mention Has Been Unlocked'
   elseif lang then
			text = 'قفل فراخوانی غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_mention"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabic' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_arabic"]
		if chklock == "❎" then
   if not lang then
			text = 'Arabic Has Been Locked'
   elseif lang then
			text = 'قفل عربی فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_arabic"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Arabic Has Been Unlocked'
   elseif lang then
			text = 'قفل عربی غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpage' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_webpage"]
		if chklock == "❎" then
   if not lang then
			text = 'Webpage Has Been Locked'
   elseif lang then
			text = 'قفل صفحات وب فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_webpage"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Webpage Has Been Unlocked'
   elseif lang then
			text = 'قفل صفحات وب غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_markdown"]
		if chklock == "❎" then
   if not lang then
			text = 'Markdown Has Been Locked'
   elseif lang then
			text = 'قفل فونت فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_markdown"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Markdown Has Been Unlocked'
   elseif lang then
			text = 'قفل فونت غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockpin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_pin"]
		if chklock == "❎" then
   if not lang then
			text = 'Pin Has Been Locked'
   elseif lang then
			text = 'قفل سنجاق کردن فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_pin"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Pin Has Been Unlocked'
   elseif lang then
			text = 'قفل سنجاق کردن غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_pin"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockbots' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_bots"]
		if chklock == "❎" then
   if not lang then
			text = 'Bots Has Been Locked'
   elseif lang then
			text = 'قفل ربات ها فعال شد'
    end
            data[tostring(matches[2])]["settings"]["lock_bots"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Bots Has Been Unlocked'
   elseif lang then
			text = 'قفل ربات ها غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_bots"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/welcome' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["welcome"]
		if chklock == "❎" then
   if not lang then
			text = 'Welcome Has Been Enabled'
   elseif lang then
			text = 'خوش آمد گویی فعال شد'
    end
            data[tostring(matches[2])]["settings"]["welcome"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chklock == "✅" then
   if not lang then
			text = 'Welcome Has Been Disabled'
   elseif lang then
			text = 'خوش آمد گویی غیر فعال شد'
    end
			data[tostring(matches[2])]["settings"]["welcome"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/floodup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) < 30 then
			flood_max = tonumber(flood_max) + 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Sensitivity Has Been Set To : "..flood_max
   elseif lang then
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/flooddown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) > 2 then
			flood_max = tonumber(flood_max) - 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Sensitivity Has Been Set To : "..flood_max
   elseif lang then
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/charup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) < 1000 then
			char_max = tonumber(char_max) + 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Character Sensitivity Has Been Set To : "..char_max
   elseif lang then
			text = "تعداد حروف مجاز تنظیم شد به : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/chardown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) > 2 then
			char_max = tonumber(char_max) - 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Character Sensitivity Has Been Set To : "..char_max
   elseif lang then
			text = "تعداد حروف مجاز تنظیم شد به : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimeup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) < 10 then
			check_time = tonumber(check_time) + 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Check Time Has Been Set To : "..check_time
   elseif lang then
			text = "زمان بررسی پیام های مکرر تنظیم شد به : "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimedown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) > 2 then
			check_time = tonumber(check_time) - 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Check Time Has Been Set To : "..check_time
   elseif lang then
			text = "زمان بررسی پیام های مکرر تنظیم شد به : "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end

			-- ###################### Mute ###################### --
			
if matches[1] == '/muteall' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_all"]
		if chkmute == "❎" then
    if not lang then
			text = 'All Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن همه فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_all"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'All Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن همه غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_all"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegif' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_gif"]
		if chkmute == "❎" then
    if not lang then
			text = 'Gifs Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن تصاویر متحرک فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_gif"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Gifs Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن تصاویر متحرک غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetext' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_text"]
		if chkmute == "❎" then
    if not lang then
			text = 'Text Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن متن فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_text"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Text Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن متن غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_text"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteinline' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_inline"]
		if chkmute == "❎" then
    if not lang then
			text = 'Inline Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن اینلاین فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_inline"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Inline Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن اینلاین غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegame' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_game"]
		if chkmute == "❎" then
    if not lang then
			text = 'Game Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن بازی فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_game"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Game Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن بازی غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_game"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutephoto' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_photo"]
		if chkmute == "❎" then
    if not lang then
			text = 'Photo Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن عکس فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_photo"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Photo Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن عکس غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideo' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_video"]
		if chkmute == "❎" then
    if not lang then
			text = 'Video Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن فیلم فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_video"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Video Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن فیلم غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_video"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudio' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_audio"]
		if chkmute == "❎" then
    if not lang then
			text = 'Audio Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن آهنگ فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_audio"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Audio Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن آهنگ غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_voice"]
		if chkmute == "❎" then
    if not lang then
			text = 'Voice Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن صدا فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_voice"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Voice Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن صدا غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutesticker' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_sticker"]
		if chkmute == "❎" then
    if not lang then
			text = 'Sticker Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن استیکر فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_sticker"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Sticker Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن استیکر غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontact' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_contact"]
		if chkmute == "❎" then
    if not lang then
			text = 'Contact Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن مخاطب فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_contact"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Contact Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن مخاطب غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforward' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_forward"]
		if chkmute == "❎" then
    if not lang then
			text = 'Forward Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن نقل و قول فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_forward"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Forward Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن نقل و قول غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocation' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_location"]
		if chkmute == "❎" then
    if not lang then
			text = 'Location Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن موقعیت فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_location"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Location Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن موقعیت غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_location"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocument' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_document"]
		if chkmute == "❎" then
    if not lang then
			text = 'Document Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن فایل فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_document"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Document Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن فایل غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_document"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetgservice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_tgservice"]
		if chkmute == "❎" then
    if not lang then
			text = 'TgService Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن خدمات تلگرام فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'TgService Has Been Unmuted'
    elseif lang then
        text = 'بیصدا کردن خدمات تلگرام غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboard' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
		if chkmute == "❎" then
    if not lang then
			text = 'Keyboard Has Been Muted'
    elseif lang then
        text = 'بیصدا کردن کیبورد شیشه ای فعال شد'
    end
            data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "✅"
			save_data(_config.moderation.data, data)
		elseif chkmute == "✅" then
    if not lang then
			text = 'Keyboard Has Been uted'
    elseif lang then
        text = 'بیصدا کردن کیبورد شیشه ای غیر فعال شد'
    end
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "❎"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end

            -- ####################### More #######################--
			
if matches[1] == '/more' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    if not lang then
		local text = 'Welcome To More Option'
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> OwnerList", callback_data="/ownerlist:"..matches[2]},
				{text = "> ModList", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "> SillentList", callback_data="/silentlist:"..matches[2]},
				{text = "> FilterList", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "> BanList", callback_data="/bans:"..matches[2]},
				{text = "> WhiteList", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "> Group Link", callback_data="/link:"..matches[2]},
				{text = "> Group Rules", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "> Show Welcome", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "> Back To Option", callback_data="/option:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> لیست مالکین", callback_data="/ownerlist:"..matches[2]},
				{text = "> لیست مدیران", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "> لیست سایلنت", callback_data="/silentlist:"..matches[2]},
				{text = "> لیست فیلتر", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "> لیست بن", callback_data="/bans:"..matches[2]},
				{text = "> لیست سفید", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "> لینک گروه", callback_data="/link:"..matches[2]},
				{text = "> قوانین گروه", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "> نمایش پیام خوشامد", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "> بازگشت به تنظیمات کلی", callback_data="/option:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/ownerlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['owners']) == nil then --fix way
     if not lang then
			text = "_No_ *owner* _in this group_"
   elseif lang then
			text = "_هیچ مالکی برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "*List Of Group Owners :*\n"
   elseif lang then
			text = "_لیست مالکین گروه :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Demote All Owners", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> برکناری تمام مالکین", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanowners' then
	if not is_admin1(msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Bot Admin")
   elseif lang then
		get_alert(msg.cb_id, "شما ادمین ربات نیستید")
   end
	else
		if next(data[tostring(matches[2])]['owners']) == nil then
     if not lang then
			text = "_No_ *owner* _in this group_"
   elseif lang then
			text = "_هیچ مالکی برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "_All_ *Group Owners* _Has Been_ *Demoted*"
   elseif lang then
			text = "_تمام مالکین از مقام خود برکنار شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				data[tostring(matches[2])]['owners'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/ownerlist:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/ownerlist:"..matches[2]}
			}
		}
   end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/filterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then --fix way
   if not lang then
			text = "*Filter List* _Is Empty_"
     elseif lang then
			text = "_لیست کلمات فیلتر شده خالی است_"
     end
		else 
			local i = 1
   if not lang then
			text = '*List Of Filtered Words List :*\n'
     elseif lang then
			text = '_لیست کلمات فیلتر شده :_\n'
    end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				text = text..''..i..' - '..check_markdown(k)..'\n'
				i = i + 1
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Clean", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> پاک کردن", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanfilterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then
   if not lang then
			text = "*Filter List* _Is Empty_"
     elseif lang then
			text = "_لیست کلمات فیلتر شده خالی است_"
     end
		else
   if not lang then
			text = "*Filter List* _Has Been_ *Cleaned*"
     elseif lang then
			text = "_لیست کلمات فیلتر پاک شد_"
     end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				data[tostring(matches[2])]['filterlist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/filterlist:"..matches[2]}
			}
		}
     elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/filterlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/modlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['mods']) == nil then --fix way
     if not lang then
			text = "_No_ *moderator* _in this group_"
   elseif lang then
			text = "_هیچ مدیری برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "*List Of Moderators :*\n"
   elseif lang then
			text = "_لیست مدیران گروه :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Demote All Moderators", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> برکناری تمام مدیران", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanmods' then
	if not is_owner1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Group Owner")
   elseif lang then
		get_alert(msg.cb_id, "شما صاحب گروه نیستید")
   end
	else
		if next(data[tostring(matches[2])]['mods']) == nil then
     if not lang then
			text = "_No_ *moderator* _in this group_"
   elseif lang then
			text = "_هیچ مدیری برای گروه تعیین نشده_"
   end
		else
     if not lang then
			text = "_All_ *Moderators* _Has Been_ *Demoted*"
   elseif lang then
			text = "_تمام مدیران از مقام خود برکنار شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				data[tostring(matches[2])]['mods'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/modlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/bans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['banned']) == nil then --fix way
     if not lang then
			text = "_No_ *banned users* _in this group_"
   elseif lang then
			text = "_هیچ فردی از این گروه محروم نشده_"
   end
		else
     if not lang then
			text = "*List Of Banned Users :*\n"
   elseif lang then
			text = "_لیست افراد محروم شده از گروه :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Unban All Banned Users", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> پاک کردن لیست بن ", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/silentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then --fix way
     if not lang then
			text = "_No_ *silent users* _in this group_"
   elseif lang then
			text = "_هیچ فردی در این گروه سایلنت نشده_"
   end
		else
     if not lang then
			text = "*List Of Silent Users :*\n"
   elseif lang then
			text = "_لیست افراد سایلنت شده :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Unsilent All Silent Users", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> پاک کردن لیست سایلنت", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleansilentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then
     if not lang then
			text = "_No_ *silent users* _in this group_"
   elseif lang then
			text = "_هیچ فردی در این گروه سایلنت نشده"
   end
		else
     if not lang then
			text = "_All_ *Silent Users* _Has Been_ *Unsilent*"
   elseif lang then
			text = "_تمام افراد سایلنت شده از سایلنت خارج شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				data[tostring(matches[2])]['is_silent_users'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/silentlist:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/silentlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanbans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['banned']) == nil then
     if not lang then
			text = "_No_ *banned users* _in this group_"
   elseif lang then
			text = "_هیچ فردی از این گروه محروم نشده"
   end
		else
     if not lang then
			text = "_All_ *Banned Users* _Has Been_ *Unbanned*"
   elseif lang then
			text = "_تمام افراد محروم شده از محرومیت این گروه خارج شدند_"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				data[tostring(matches[2])]['banned'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/bans:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/bans:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/link' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local linkgp = data[tostring(matches[2])]['settings']['linkgp']
		if not linkgp then
   if not lang then
			text = "_First set a_ *link* _for group with using_ /setlink"
    elseif lang then
			text = "_ابتدا با دستور_ setlink/ _لینک جدیدی برای گروه تعیین کنید_"
  end
		else
   if not lang then
			text = "[Group Link Is Here]("..linkgp..")"
    elseif lang then
			text = "[لینک گروه اینجاست]("..linkgp..")"
        end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/rules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
   if not lang then
     text = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban."
    elseif lang then
       text = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود."
 end
		elseif rules then
     if not lang then
			text = '*Group Rules :*\n'..rules
   elseif lang then
			text = '_قوانین گروه :_\n'..rules
       end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Clean", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> پاک کردن", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanrules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
    if not lang then
			text = "`No Rules Available`"
   elseif lang then
			text = "_قوانین گروه ثبت نشده_"
   end
		else
    if not lang then
			text = "*Group Rules* _Has Been_ *Cleaned*"
   elseif lang then
			text = "_قوانین گروه پاک شد_"
  end
			data[tostring(matches[2])]['rules'] = nil
			save_data(_config.moderation.data, data)
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/rules:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/rules:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
		if matches[1] == '/whitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "_White List is Empty._"
			else
				text = "_لیست سفید خالی می باشد._"
			end
		else 
			local i = 1
			if not lang then
				text = '_> White List:_ \n'
			else
				text = '_> لیست سفید:_ \n'
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				text = text..''..i..' - '..check_markdown(v)..' ' ..k.. ' \n'
				i = i + 1
			end
		end
		local keyboard = {}
		if not lang then
		keyboard.inline_keyboard = {
			{
				{text = "> Clean White List", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{
				{text = "> حذف لیست سفید", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end

if matches[1] == '/cleanwhitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "_White List is Empty._"
			else
				text = "_لیست سفید خالی می باشد._"
			end
		else
			if not lang then
				text = "_White List Was Cleared._"
			else
				text = "_لیست سفید حذف شد._"
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				data[tostring(matches[2])]['whitelist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
		end
end
if matches[1] == '/showwlc' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "_Welcome Message Not Set._\n*Default Message :* _Welcome Dude_"
			else
				text = "_پیام خوشامد تنظیم نشده است._"
			end
		else
		if not lang then
			text = '_Welcome Message:_\n'..wlc
		else
			text = '_پیام خوشامد:_\n'..wlc
		end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {
			{ 
				{text = "> Clean Welcome Message", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{ 
				{text = "> حذف پیام خوشامد", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwlcmsg' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "_Welcome Message Not Set._"
			else
				text = "_پیام خوشامد تنظیم نشده است._"
			end
		else
		if not lang then
			text = '_Welcome Message Was Cleaned._'
		else
			text = '_پیام خوشامد حذف شد._'
		end
		data[tostring(matches[2])]['setwelcome'] = nil
		save_data(_config.moderation.data, data)
end
local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "> بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
         -- ####################### About Us ####################### --
if matches[1] == '/beyond' then
	local text = _config.info_text
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> SoLiD", callback_data="/solid:"..matches[2]}, 
			{text = "> ToOfan", callback_data="/toofan:"..matches[2]}
		},
		{
			{text = '> Our GitHub ', url = 'https://www.github.com/BeyondTeam'}
		},
		{
			{text= '> Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> سعید", callback_data="/solid:"..matches[2]}, 
			{text = "> طوفان", callback_data="/toofan:"..matches[2]}
		},
		{
			{text = '> گیت هاب تیم ', url = 'https://www.github.com/BeyondTeam'}
		},
		{
			{text= '> بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

if matches[1] == '/solid' then
local text = [[]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/beyond:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/beyond:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/toofan' then
local text = [[]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/beyond:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> بازگشت", callback_data="/beyond:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/exit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    if not lang then
		 text = '*Group Option Closed*'
   elseif lang then
		 text = '_تنظیمات کلی بسته شده_'
   end
		edit_inline(msg.message_id, text)
	end
end

end
--------------End Inline Query---------------
end

local function pre_process(msg)
-- print(serpent.block(msg), {comment=false})
--leave_group(msg.chat.id)
end

return {
	patterns ={
		"^-(%d+)$",
		"^###cb:(%d+)$",
		"^[/](sudolist)$",
		"^[/](setsudo)$",
		"^[/](remsudo)$",
		"^[/](setsudo) (%d+)$",
		"^[/](remsudo) (%d+)$",
		"^###cb:(/option):(.*)$",
		"^###cb:(/lang):(.*)$",
		"^###cb:(/persian):(.*)$",
		"^###cb:(/english):(.*)$",
		"^###cb:(/settings):(.*)$",
		"^###cb:(/mutelist):(.*)$",
		"^###cb:(/locklink):(.*)$",
		"^###cb:(/lockedit):(.*)$",
		"^###cb:(/locktags):(.*)$",
		"^###cb:(/lockjoin):(.*)$",
		"^###cb:(/lockpin):(.*)$",
		"^###cb:(/lockmarkdown):(.*)$",
		"^###cb:(/lockmention):(.*)$",
		"^###cb:(/lockarabic):(.*)$",
		"^###cb:(/lockwebpage):(.*)$",
		"^###cb:(/lockbots):(.*)$",
		"^###cb:(/lockspam):(.*)$",
		"^###cb:(/lockflood):(.*)$",
		"^###cb:(/welcome):(.*)$",
		"^###cb:(/muteall):(.*)$",
		"^###cb:(/mutegif):(.*)$",
		"^###cb:(/mutegame):(.*)$",
		"^###cb:(/mutevideo):(.*)$",
		"^###cb:(/mutevoice):(.*)$",
		"^###cb:(/muteinline):(.*)$",
		"^###cb:(/mutesticker):(.*)$",
		"^###cb:(/mutelocation):(.*)$",
		"^###cb:(/mutedocument):(.*)$",
		"^###cb:(/muteaudio):(.*)$",
		"^###cb:(/mutephoto):(.*)$",
		"^###cb:(/mutetext):(.*)$",
		"^###cb:(/mutetgservice):(.*)$",
		"^###cb:(/mutekeyboard):(.*)$",
		"^###cb:(/mutecontact):(.*)$",
		"^###cb:(/muteforward):(.*)$",
		"^###cb:(/toofan):(.*)$",
		"^###cb:(/setflood):(.*)$",
		"^###cb:(/floodup):(.*)$",
		"^###cb:(/flooddown):(.*)$",
		"^###cb:(/charup):(.*)$",
		"^###cb:(/chardown):(.*)$",
		"^###cb:(/floodtimeup):(.*)$",
		"^###cb:(/floodtimedown):(.*)$",
		"^###cb:(/moresettings):(.*)$",
		"^###cb:(/more):(.*)$",
		"^###cb:(/ownerlist):(.*)$",
		"^###cb:(/cleanowners):(.*)$",
		"^###cb:(/modlist):(.*)$",
		"^###cb:(/cleanmods):(.*)$",
		"^###cb:(/bans):(.*)$",
		"^###cb:(/beyond):(.*)$",
		"^###cb:(/cleanbans):(.*)$",
		"^###cb:(/filterlist):(.*)$",
		"^###cb:(/cleanfilterlist):(.*)$",
		"^###cb:(/whitelist):(.*)$",
		"^###cb:(/cleanwhitelist):(.*)$",
		"^###cb:(/silentlist):(.*)$",
		"^###cb:(/solid):(.*)$",
		"^###cb:(/cleansilentlist):(.*)$",
		"^###cb:(/link):(.*)$",
		"^###cb:(/rules):(.*)$",
		"^###cb:(/cleanrules):(.*)$",
		"^###cb:(/exit):(.*)$",
		"^###cb:(/whitelists):(.*)$",
		"^###cb:(/cleanwhitelists):(.*)$",
		"^###cb:(/showwlc):(.*)$",
		"^###cb:(/cleanwlcmsg):(.*)$",

	},
	run=run,
	pre_process=pre_process
}
