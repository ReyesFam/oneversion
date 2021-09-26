require "lib.moonloader" -- подключение библиотеки
local keys = require "vkeys"
local imgui = require 'imgui'
local memory = require 'memory'
local hook = require 'lib.samp.events'
local ffi = require 'ffi'
local pie = require 'imgui_piemenu'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local rkeys = require 'rkeys'
imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar
if not doesDirectoryExist("moonloader\\OneVersion") then
	createDirectory("moonloader\\OneVersion")
end
if not doesFileExist('moonloader\\lib\\rkeys.lua') then
    downloadUrlToFile('https://vk.com/doc-150243071_558659669?dl=7f470f6e364cee7c57',"moonloader\\lib\\rkeys.lua")
end
if not doesFileExist('moonloader\\lib\\imgui_addons.lua') then
    downloadUrlToFile('https://vk.com/doc-150243071_558659655?dl=e41c6a1e12c79d5326',"moonloader\\lib\\imgui_addons.lua")
end
local dlstatus = require("moonloader").download_status
local inicfg = require "inicfg"
local as_action = require('moonloader').audiostream_state
local directIni = "oneversion.ini"
local mainIni = inicfg.load({
	config = {
		four = false,
		one = false,
		five = false,
		three = false,
		house = "h",
		timer = false,
		menu1 = 'p2',
		biz = 'fb',
		two = false,
		menu = 'p1',
		helper = 'rf',
		test = false,
		fill = false,
		theme = 0,
		FishEyeEffect = false,
		phone = false,
		fh = false,
		piarcmd = "piar",
		piar1 = " ",
		piar2 = " ",
		piar3 = " ",
		piartime = 300,
		piaron1 = false,
		piaron2 = false,
		piaron3 = false,
		enter = false,
		del = "deleteplayers",
		roul = "roulette",
		supreme = false,
		TThide = false
	}
}, directIni)
local stateIni = inicfg.save(mainIni, directIni)
update_state = false
local script_vers = 34
local script_vers_text = "3.0"
local update_url = "https://raw.githubusercontent.com/ReyesFam/oneversion/master/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"
local script_url = "https://github.com/ReyesFam/oneversion/blob/master/oneversion.luac?raw=true"
local script_path = thisScript().path
local tag = "Helper"
local MASLOSYKA = {"Family", "Dynasty", "Corporation", "Squad", "Crew", "Empire", "Brotherhood"}
local main_window_state = imgui.ImBool(false)
local new_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local sw, sh = getScreenResolution()
local house = imgui.ImBuffer(mainIni.config.house, 500)
local biz = imgui.ImBuffer(mainIni.config.biz, 500)
local helper = imgui.ImBuffer(mainIni.config.helper, 500)
local antiafk = imgui.ImBool(true)
local one = imgui.ImBool(mainIni.config.one)
local two = imgui.ImBool(mainIni.config.two)
local bNotf, notf = pcall(import, "imgui_notf.lua")
local menu = imgui.ImBuffer(mainIni.config.menu, 500)
local menu1 = imgui.ImBuffer(mainIni.config.menu1, 500)
local turbocontrol = imgui.ImBool(mainIni.config.three)
local repitvr = imgui.ImBool(mainIni.config.four)
local five = imgui.ImBool(mainIni.config.five)
local timer = imgui.ImBool(mainIni.config.timer)
local fill = imgui.ImBool(mainIni.config.fill)
local FishEyeEffect = imgui.ImBool(mainIni.config.FishEyeEffect)
local phone = imgui.ImBool(mainIni.config.phone)
local fh = imgui.ImBool(mainIni.config.fh)
local piarcmd = imgui.ImBuffer(mainIni.config.piarcmd, 500)
local piar1 = imgui.ImBuffer(mainIni.config.piar1, 500)
local piar2 = imgui.ImBuffer(mainIni.config.piar2, 500)
local piar3 = imgui.ImBuffer(mainIni.config.piar3, 500)
local piartime = imgui.ImInt(mainIni.config.piartime)
local piaron1 = imgui.ImBool(mainIni.config.piaron1)
local piaron2 = imgui.ImBool(mainIni.config.piaron2)
local piaron3 = imgui.ImBool(mainIni.config.piaron3)
local enter = imgui.ImBool(mainIni.config.enter)
local del = imgui.ImBuffer(mainIni.config.del, 500)
local roul = imgui.ImBuffer(mainIni.config.roul, 500)
local btn_size = imgui.ImBool(false)
local piemenu = imgui.ImBool(false)
local supreme = imgui.ImBool(mainIni.config.supreme)
local TThide = imgui.ImBool(mainIni.config.TThide) 
local users = {
	Mia_Boyka = 0,
	Leonardo_Reyes = 0,
	Leopold_Reyes = 0,
	Leonhard_Reyes = 0,
	Leonard_Reyes = 0,
	Shon_Reyes = 0,
	Shon_Snake = 0,
	Hola_Costa = 0,
	Peresvet_Reyes = 0,
	Wolfram_Wens = 0,
	Banhamamban_Reyes = 0,
	Theodore_Reyes = 0,
	Greenwald_Le = 0,
	Leopold_Ornul = 0,
	Dewsbarry_Reyes = 0,
	Yaroslav_Zakonov = 0,
	Benjamin_Wassermann = 0,
	Guglielmo_Reyes = 0
}
local iparz = {
	Phoenix = "185.169.134.3:7777",
	Tucson = "185.169.134.4:7777",
	Scottdale = "185.169.134.43:7777",
	Chandler = "185.169.134.44:7777",
	Brainburg = "185.169.134.45:7777",
	SaintRose = '185.169.134.5:7777',
	Mesa = '185.169.134.59:7777',
	RedRock = "185.169.134.61:7777",
	Yuma = '185.169.134.107:7777',
	Surprise = '185.169.134.109:7777',
	Prescott = '185.169.134.166:7777',
	Glendale = "185.169.134.171:7777",
	Kingman = "185.169.134.172:7777",
	Winslow = "185.169.134.173:7777",
	Training = '37.230.162.117:7777'
}
local theme = imgui.ImInt(mainIni.config.theme)
local thememetod = {
u8'Фиолетовая тема',
u8'Бирюзовая тема',
u8'Коричневая тема',
u8'Красная тема'
}

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand(tostring(mainIni.config.helper), cmd_imgui)
	sampRegisterChatCommand("imgui", cmd_imgui2)
	sampRegisterChatCommand(tostring(mainIni.config.house), cmd_h)
	sampRegisterChatCommand(tostring(mainIni.config.biz), cmd_b)
	sampRegisterChatCommand(tostring(mainIni.config.menu), cmd_p)
	sampRegisterChatCommand(tostring(mainIni.config.menu1), cmd_p1)
	sampRegisterChatCommand(tostring(mainIni.config.piarcmd), piar)
	sampRegisterChatCommand(tostring(mainIni.config.del), delplayers)
	sampRegisterChatCommand(tostring(mainIni.config.roul), roulette)
  antipause()
	checkip()

	thread = lua_thread.create_suspended(thread_function)
	FishEye = lua_thread.create(FishEye)
	dirMusic = loadAudioStream('moonloader/OneVersion/fh.mp3')
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				notf.addNotification(tag .. " | Доступно обновление! Версия: " .. updateIni.info.vers_text, 2, 3)
				update_state = true
			end
			os.remove(update_path)
		end
	end)

  imgui.Process = false

	sampAddChatMessage(tag .. " {00FF7F}| {ffffff}Скрипт успешно загружен",0xFF1493)


	-- Блок выполняется один раз после старта сампа

	while true do
		wait(0)
		imgui.Process = main_window_state.v or new_window_state.v or piemenu.v
		if not main_window_state.v then new_window_state.v = false end
		if not main_window_state.v and not new_window_state.v and piemenu.v then imgui.ShowCursor = false end
		if main_window_state.v and piemenu.v then imgui.ShowCursor = true end
		if main_window_state.v and not piemenu.v then imgui.ShowCursor = true end
		if main_window_state.v or new_window_state.v then piemenu.v = false end
		if not main_window_state.v and not new_window_state.v and not piemenu.v then imgui.ShowCursor = false end
		local nickname = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
		if users[nickname] ~= 0 then thisScript():unload() end
		if theme.v == 0 then
			stok_style()
		end
		if theme.v == 1 then
			lightBlue()
		end
		if theme.v == 2 then
			apply_custom_style()
		end
		if theme.v == 3 then
			redTheme()
		end
		if wasKeyPressed(keys.VK_X) and not sampIsDialogActive() and not sampIsChatInputActive() then
			piemenu.v = not piemenu.v
			if piemenu.v then notf.addNotification(tag .. " | Вы разрешили управление PieMenu", 2, 3) end
			if not piemenu.v then notf.addNotification(tag .. " | Вы запретили управление PieMenu", 2, 3) end
		end
		if sampIsDialogActive() or sampIsChatInputActive() then
			piemenu.v = false
		end
		if timer.v then
			if sampIsDialogActive() and (sampGetCurrentDialogId() == 8869 or sampGetCurrentDialogId() == 8868) then
			ttime = os.clock()
			while sampIsDialogActive() do
				wait(0)
			end
			print(string.format("{01A0E9}[Таймер]: {FFFFFF}Капча {01A0E9}[%s] {FFFFFF}ввел за {01A0E9}[%s] {FFFFFF}секунд",sampGetCurrentDialogEditboxText(), string.sub(os.clock() - ttime, 1, 5)), 16777215)
			end
		end
		window = ffi.C.GetActiveWindow()
		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					notf.addNotification(tag .. " | Обновление скрипта прошло успешно!", 2, 3)
					thisScript():reload()
				end
			end)
			break
		end
		-- блок выполняется бесконечно (пока самп активен)
	end
end
function roulette() taks = not taks if taks then sampAddChatMessage(tag.. " {00FF7F}| {ffffff}Автоматическая прокрутка рулеток включена", 0xFF1493) end if not taks then sampAddChatMessage(tag.. " {00FF7F}| {ffffff}Автоматическая прокрутка рулеток завершена", 0xFF1493) end end
function cmd_imgui(arg)
  main_window_state.v = not main_window_state.v
  imgui.Process = main_window_state.v
end

function cmd_imgui2(arg)
  new_window_state.v = not new_window_state.v
  imgui.Process = new_window_state.v
end

function imgui.OnDrawFrame()
	if not main_window_state.v and not new_window_state.v and not piemenu.v then
		imgui.Process = false
	end
	if main_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(750, 600), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin("Helper for Reyes Family", main_window_state)
    if imgui.CollapsingHeader(u8"Функции") then
		imgui.Button(u8'АнтиАфк', antiafk)
		imgui.Text(u8"- Постоянно включен", imgui.SameLine())
		ShowHelpMarker(u8"Открывает риелторку на PayDay")
		imgui.ToggleButton(u8"##1", one, imgui.SameLine())
		mainIni.config.one = one.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"Чекер риелторки (Samsung, iPhone)", imgui.SameLine())
		ShowHelpMarker(u8"Открывает риелторку на PayDay")
		imgui.ToggleButton(u8"##2", two, imgui.SameLine())
		mainIni.config.two = two.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"Чекер риелторки (Huawei)", imgui.SameLine())
		ShowHelpMarker(u8"Транспорт в который вы сядете - всегда ТТ")
		imgui.ToggleButton(u8'##3',turbocontrol, imgui.SameLine())
		mainIni.config.three = turbocontrol.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"TwinTurboControl", imgui.SameLine())
		ShowHelpMarker(u8"Если анти спам система не позволила отправить сообщение в /vr скрипт отправит его сам через секунду")
		imgui.ToggleButton(u8'##4',repitvr, imgui.SameLine())
		mainIni.config.four = repitvr.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"RepitVR", imgui.SameLine())
		ShowHelpMarker(u8'Отключает ник и название семьи над игроком.\n(название семье не вернется)')
		if imgui.ToggleButton(u8'##5', five, imgui.SameLine()) then
				pStSet = sampGetServerSettingsPtr()
				if five.v then
						memory.setint8(pStSet + 56, 0)
						for i = 1, 2048 do
								if sampIs3dTextDefined(i) then
										local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(i)
										for ii = 1, #MASLOSYKA do if text:match(string.format('.+%s', MASLOSYKA[tonumber(ii)])) then sampDestroy3dText(i) end end
								end
						end
				else
						memory.setint8(pStSet + 56, 1)
				end
		end
		mainIni.config.five = five.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"Отключить ники и семьи", imgui.SameLine())
		ShowHelpMarker(u8"Пишет в панель SampFuncs капчу и время за сколько вы ввели")
		imgui.ToggleButton(u8"##6", timer, imgui.SameLine())
		mainIni.config.timer = timer.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"Таймер ловли", imgui.SameLine())
		ShowHelpMarker(u8"Автоматически заправляет ваш транспорт на АЗС")
		imgui.ToggleButton(u8"##7", fill, imgui.SameLine())
		mainIni.config.fill = fill.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"AutoFill", imgui.SameLine())
		ShowHelpMarker(u8"Увеличивает угол обзора камеры")
		imgui.ToggleButton(u8"##8", FishEyeEffect, imgui.SameLine())
		mainIni.config.FishEyeEffect = FishEyeEffect.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"Рыбий глаз", imgui.SameLine())
		ShowHelpMarker(u8"Когда вы находитесь в АнтиАФК и Вам позвонят на телефон, то Вам высветиться оповещающее окно")
		imgui.ToggleButton(u8"##9", phone, imgui.SameLine())
		mainIni.config.phone = phone.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"PhoneMessage", imgui.SameLine())
		ShowHelpMarker(u8"Когда слетает топовый дом, то включается звук уведомляющий вас об этом\n(Должно быть включено радио в настройках)")
		imgui.ToggleButton("##10", fh, imgui.SameLine())
		mainIni.config.fh = fh.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"TopHouse", imgui.SameLine())
		ShowHelpMarker(u8"При табличке о покупки авто автоматически нажмётся Enter")
		imgui.ToggleButton(u8"##13", enter, imgui.SameLine())
		mainIni.config.enter = enter.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"AutoBuyCar", imgui.SameLine())
		ShowHelpMarker(u8"Удаляет видимость найклейки Суприм\n(Необходимо перезайти в прорисовку)")
		imgui.ToggleButton(u8"##14", supreme, imgui.SameLine())
		mainIni.config.supreme = supreme.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"SupremeHide", imgui.SameLine())
		ShowHelpMarker(u8"Удаляет видимость найклейки ТвинТурбо\n(Необходимо перезайти в прорисовку)")
		imgui.ToggleButton(u8"##15", TThide, imgui.SameLine())
		mainIni.config.TThide = TThide.v
		inicfg.save(mainIni, directIni)
		imgui.Text(u8"TTHide", imgui.SameLine())
	 end
	 if imgui.CollapsingHeader(u8"Команды") then
		 ShowHelpMarker(u8"Сокращённая команда для домов")
		 imgui.PushItemWidth(100)
		 if imgui.InputText("/findihouse", house, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.house)
			 mainIni.config.house = house.v
			 inicfg.save(mainIni, directIni)
			 sampRegisterChatCommand(tostring(mainIni.config.house), cmd_h)
		 end
		 imgui.PopItemWidth()
		 ShowHelpMarker(u8"Сокращённая команда для бизнесов")
		 imgui.PushItemWidth(100)
		 if imgui.InputText("/findibiz", biz, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.biz)
			 mainIni.config.biz = biz.v
			 inicfg.save(mainIni, directIni)
			 sampRegisterChatCommand(tostring(mainIni.config.biz), cmd_b)
		 end
		 imgui.PopItemWidth()
		 imgui.Separator()
		 ShowHelpMarker(u8"Команда для открытия меню телефона")
		 imgui.PushItemWidth(100)
		 if imgui.InputText(u8"Открытие телефона (Samsung, iPhone)", menu, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.menu)
			 mainIni.config.menu = menu.v
			 inicfg.save(mainIni, directIni)
			 sampRegisterChatCommand(tostring(mainIni.config.menu), cmd_p)
		 end
		 imgui.PopItemWidth()
		 ShowHelpMarker(u8"Команда для открытия меню телефона")
		 imgui.PushItemWidth(100)
		 if imgui.InputText(u8"Открытие телефона (Huawei)", menu1, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.menu1)
			 mainIni.config.menu1 = menu1.v
			 inicfg.save(mainIni, directIni)
			 sampRegisterChatCommand(tostring(mainIni.config.menu1), cmd_p1)
		 end
		 imgui.PopItemWidth()
		 imgui.Separator()
		 ShowHelpMarker(u8"Команда для удаления игроков в зоне стрима\n(Чтобы вернуть игроков назад, необходимо перезайти в данную область стрима)")
		 imgui.PushItemWidth(100)
		 if imgui.InputText(u8"Удаление игроков", del, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.del)
			 mainIni.config.del = del.v
			 inicfg.save(mainIni, directIni)
			 sampRegisterChatCommand(tostring(mainIni.config.del), delplayers)
		 end
		 imgui.PopItemWidth(100)
		 ShowHelpMarker(u8"Автоматически прокручивает рулетку\n(Первый прокрут делайте самостоятельно)")
		 imgui.PushItemWidth(100)
		 if imgui.InputText(u8"Авто рулетка", roul, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.roul)
			 mainIni.config.roul = roul.v
			 inicfg.save(mainIni, directIni)
			 sampRegisterChatCommand(tostring(mainIni.config.roul), roulette)
		 end
		 imgui.PopItemWidth(100)
	 end
	 if imgui.CollapsingHeader(u8"Пиар") then
		 ShowHelpMarker(u8"Команда для активации пиара")
		 imgui.PushItemWidth(100)
		 if imgui.InputText(u8"Команда", piarcmd, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.piarcmd)
			 mainIni.config.piarcmd = piarcmd.v
			 inicfg.save(mainIni, directIni)
			 sampRegisterChatCommand(tostring(mainIni.config.piarcmd), piar)
		 end
		 imgui.PopItemWidth(100)
		 ShowHelpMarker(u8"Задержка между пиарами")
		 if imgui.SliderInt(u8'Задержка (сек)', piartime, 10, 300, imgui.SameLine()) then
			 mainIni.config.piartime = piartime.v
			 inicfg.save(mainIni, directIni)
		 end
		 ShowHelpMarker(u8"Активировать/деактивировать первую строчку\nТекст для пиара первой строчки")
		 if imgui.ToggleButton(u8"##11", piaron1, imgui.SameLine()) then
			 mainIni.config.piaron1 = piaron1.v
			 inicfg.save(mainIni, directIni)
		 end
		 if imgui.InputText(u8"Первый пиар", piar1, imgui.SameLine()) then
			 mainIni.config.piar1 = piar1.v
			 inicfg.save(mainIni, directIni)
		 end
		 ShowHelpMarker(u8"Активировать/деактивировать вторую строчку\nТекст для пиара второй строчки")
		 if imgui.ToggleButton(u8"##12", piaron2, imgui.SameLine()) then
			 mainIni.config.piaron2 = piaron2.v
			 inicfg.save(mainIni, directIni)
		 end
		 if imgui.InputText(u8"Второй пиар", piar2, imgui.SameLine()) then
			 mainIni.config.piar2 = piar2.v
			 inicfg.save(mainIni, directIni)
		 end
		 ShowHelpMarker(u8"Активировать/деактивировать третью строчку\nТекст для пиара третьей строчки")
		 if imgui.ToggleButton(u8"##13", piaron3, imgui.SameLine()) then
			 mainIni.config.piaron3 = piaron3.v
			 inicfg.save(mainIni, directIni)
		 end
		 if imgui.InputText(u8"Третий пиар", piar3, imgui.SameLine()) then
			 mainIni.config.piar3 = piar3.v
			 inicfg.save(mainIni, directIni)
		 end
	 end
	 if imgui.CollapsingHeader(u8"О скрипте") then
		 imgui.Text(u8"Скрипт специально для Reyes Family")
		 imgui.Text(u8"Создатель скрипта")
		 imgui.Text("Leonardo_Reyes")
		 imgui.Separator()
		 imgui.Text(u8"Активация скрипта")
		 imgui.PushItemWidth(100)
		 if imgui.InputText(" ", helper, imgui.SameLine()) then
			 sampUnregisterChatCommand(mainIni.config.helper)
			 mainIni.config.helper = helper.v
			 sampRegisterChatCommand(tostring(mainIni.config.helper), cmd_imgui)
		 end
		 imgui.Text(u8'Выбор темы меню: ')
 		imgui.PushItemWidth(200)
 		imgui.SameLine()
 		imgui.Combo(u8'', theme,thememetod, -1)
 		mainIni.config.theme = theme.v
 		inicfg.save(mainIni, directIni)
 		imgui.SameLine()
		 imgui.Separator()
		 imgui.Text(u8"В данный момент у вас версия " .. script_vers_text)
	 end
		if imgui.Button(u8"Перезагрузить скрипт") then
			lua_thread.create(function ()
					imgui.ShowCursor = false
					wait(100)
					thisScript():reload()
			end)
	  end
    imgui.Text("By Leonardo_Reyes", imgui.SameLine())
		imgui.SetCursorPosX(1250)
		imgui.SetCursorPosY(500)
		if imgui.Button(u8"Не жми сюда") then
			new_window_state.v = not new_window_state.v
		end
    imgui.End()
	end
	if new_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(100, 50), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2((sw / 2 - 425), sh / 2 - 275), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8"Пиздец", new_window_state)
		imgui.Text(u8"Ты пидор")
		imgui.End()
	end
	if piemenu.v then
		if imgui.IsMouseClicked(1) then
			imgui.OpenPopup('PieMenu')
		end
		if pie.BeginPiePopup('PieMenu', 1) then
			imgui.ShowCursor = true
			if pie.BeginPieMenu(u8'Функции') then
				if pie.PieMenuItem(u8'    TT\nControl') then
					if turbocontrol.v then turbocontrol.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию TwinTurboControl", 2, 3)
					elseif not turbocontrol.v then turbocontrol.v = true notf.addNotification(tag .. " | Вы успешно включили функцию TwinTurboControl", 2, 3) end
				end
				if pie.PieMenuItem(u8'RepitVR') then
					if repitvr.v then repitvr.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию RepitVR", 2, 3)
					elseif not repitvr.v then repitvr.v = true notf.addNotification(tag .. " | Вы успешно включили функцию RepitVR", 2, 3) end
				end
				if pie.PieMenuItem(u8'AutoFill') then
					if fill.v then fill.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию AutoFill", 2, 3)
					elseif not fill.v then fill.v = true notf.addNotification(tag .. " | Вы успешно включили функцию AutoFill", 2, 3) end
				end
				if pie.PieMenuItem(u8'Рыбий\nглаз') then
					if FishEyeEffect.v then FishEyeEffect.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию FishEye", 2, 3)
					elseif not FishEyeEffect.v then FishEyeEffect.v = true notf.addNotification(tag .. " | Вы успешно включили функцию FishEye", 2, 3) end
				end
				if pie.PieMenuItem(u8' Phone\nMessage') then
					if phone.v then phone.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию PhoneMessage", 2, 3)
					elseif not phone.v then phone.v = true notf.addNotification(tag .. " | Вы успешно включили функцию PhoneMessage", 2, 3) end
				end
				if pie.PieMenuItem(u8'  Авто\nрулетка') then
					roulette()
				end
			pie.EndPieMenu()
			end
			if pie.PieMenuItem(u8'Пиар') then
				piar()
			end
			if pie.BeginPieMenu(u8'Чекеры') then
				if pie.PieMenuItem(u8' Чекер\nSamsung\n iPhone') then
					if one.v then one.v = false notf.addNotification(tag .. " | Чекер риелторки (Samsung, iPhone) отключен", 2, 3)
					elseif not one.v then one.v = true notf.addNotification(tag .. " | Чекер риелторки (Samsung, iPhone) включен", 2, 3) end
				end
				if pie.PieMenuItem(u8' Чекер\nHuawei') then
					if two.v then two.v = false notf.addNotification(tag .. " | Чекер риелторки (Huawei) отключен", 2, 3)
					elseif not two.v then two.v = true notf.addNotification(tag .. " | Чекер риелторки (Huawei) включен", 2, 3) end
				end
			pie.EndPieMenu()
			end
			if pie.BeginPieMenu(u8'Для\nловли') then
				if pie.PieMenuItem(u8'Ники\n   и\nсемьи') then
					if five.v then five.v = false notf.addNotification(tag .. " | Вы успешно включили ники и семьи", 2, 3)
					elseif not five.v then five.v = true notf.addNotification(tag .. " | Вы успешно убрали ники и семьи", 2, 3) end
				end
				if pie.PieMenuItem(u8'Таймер\n ловли') then
					if timer.v then timer.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию Таймер Ловли", 2, 3)
					elseif not timer.v then timer.v = true notf.addNotification(tag .. " | Вы успешно включили функцию Таймер ловли", 2, 3) end
				end
				if pie.PieMenuItem(u8'TopHouse') then
					if fh.v then fh.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию TopHouse", 2, 3)
					elseif not fh.v then fh.v = true notf.addNotification(tag .. " | Вы успешно включили функцию TopHouse", 2, 3) end
				end
				if pie.PieMenuItem(u8'AutoBuyCar') then
					if enter.v then enter.v = false notf.addNotification(tag .. " | Вы успешно отключили функцию AutoBuyCar", 2, 3)
					elseif not enter.v then enter.v = true notf.addNotification(tag .. " | Вы успешно включили функцию AutoBuyCar", 2, 3) end
				end
				if pie.PieMenuItem(u8'Удалить\nигроков') then
					delplayers()
					notf.addNotification(tag .. " | Вы успешно удалили игроков в вашем радиусе", 2, 3)
				end
			pie.EndPieMenu()
			end
		pie.EndPiePopup()
		end
	end
end

function delplayers()
	for _, handle in ipairs(getAllChars()) do
      if doesCharExist(handle) then
        local _, id = sampGetPlayerIdByCharHandle(handle)
        	if id ~= myid then
        		emul_rpc('onPlayerStreamOut', { id })
        	end
      end
  	end
end
function emul_rpc(hook, parameters)
    local bs_io = require 'samp.events.bitstream_io'
    local handler = require 'samp.events.handlers'
    local extra_types = require 'samp.events.extra_types'
    local hooks = {

        --[[ Outgoing rpcs
        ['onSendEnterVehicle'] = { 'int16', 'bool8', 26 },
        ['onSendClickPlayer'] = { 'int16', 'int8', 23 },
        ['onSendClientJoin'] = { 'int32', 'int8', 'string8', 'int32', 'string8', 'string8', 'int32', 25 },
        ['onSendEnterEditObject'] = { 'int32', 'int16', 'int32', 'vector3d', 27 },
        ['onSendCommand'] = { 'string32', 50 },
        ['onSendSpawn'] = { 52 },
        ['onSendDeathNotification'] = { 'int8', 'int16', 53 },
        ['onSendDialogResponse'] = { 'int16', 'int8', 'int16', 'string8', 62 },
        ['onSendClickTextDraw'] = { 'int16', 83 },
        ['onSendVehicleTuningNotification'] = { 'int32', 'int32', 'int32', 'int32', 96 },
        ['onSendChat'] = { 'string8', 101 },
        ['onSendClientCheckResponse'] = { 'int8', 'int32', 'int8', 103 },
        ['onSendVehicleDamaged'] = { 'int16', 'int32', 'int32', 'int8', 'int8', 106 },
        ['onSendEditAttachedObject'] = { 'int32', 'int32', 'int32', 'int32', 'vector3d', 'vector3d', 'vector3d', 'int32', 'int32', 116 },
        ['onSendEditObject'] = { 'bool', 'int16', 'int32', 'vector3d', 'vector3d', 117 },
        ['onSendInteriorChangeNotification'] = { 'int8', 118 },
        ['onSendMapMarker'] = { 'vector3d', 119 },
        ['onSendRequestClass'] = { 'int32', 128 },
        ['onSendRequestSpawn'] = { 129 },
        ['onSendPickedUpPickup'] = { 'int32', 131 },
        ['onSendMenuSelect'] = { 'int8', 132 },
        ['onSendVehicleDestroyed'] = { 'int16', 136 },
        ['onSendQuitMenu'] = { 140 },
        ['onSendExitVehicle'] = { 'int16', 154 },
        ['onSendUpdateScoresAndPings'] = { 155 },
        ['onSendGiveDamage'] = { 'int16', 'float', 'int32', 'int32', 115 },
        ['onSendTakeDamage'] = { 'int16', 'float', 'int32', 'int32', 115 },]]

        -- Incoming rpcs
        ['onInitGame'] = { 139 },
        ['onPlayerJoin'] = { 'int16', 'int32', 'bool8', 'string8', 137 },
        ['onPlayerQuit'] = { 'int16', 'int8', 138 },
        ['onRequestClassResponse'] = { 'bool8', 'int8', 'int32', 'int8', 'vector3d', 'float', 'Int32Array3', 'Int32Array3', 128 },
        ['onRequestSpawnResponse'] = { 'bool8', 129 },
        ['onSetPlayerName'] = { 'int16', 'string8', 'bool8', 11 },
        ['onSetPlayerPos'] = { 'vector3d', 12 },
        ['onSetPlayerPosFindZ'] = { 'vector3d', 13 },
        ['onSetPlayerHealth'] = { 'float', 14 },
        ['onTogglePlayerControllable'] = { 'bool8', 15 },
        ['onPlaySound'] = { 'int32', 'vector3d', 16 },
        ['onSetWorldBounds'] = { 'float', 'float', 'float', 'float', 17 },
        ['onGivePlayerMoney'] = { 'int32', 18 },
        ['onSetPlayerFacingAngle'] = { 'float', 19 },
        --['onResetPlayerMoney'] = { 20 },
        --['onResetPlayerWeapons'] = { 21 },
        ['onGivePlayerWeapon'] = { 'int32', 'int32', 22 },
        --['onCancelEdit'] = { 28 },
        ['onSetPlayerTime'] = { 'int8', 'int8', 29 },
        ['onSetToggleClock'] = { 'bool8', 30 },
        ['onPlayerStreamIn'] = { 'int16', 'int8', 'int32', 'vector3d', 'float', 'int32', 'int8', 32 },
        ['onSetShopName'] = { 'string256', 33 },
        ['onSetPlayerSkillLevel'] = { 'int16', 'int32', 'int16', 34 },
        ['onSetPlayerDrunk'] = { 'int32', 35 },
        ['onCreate3DText'] = { 'int16', 'int32', 'vector3d', 'float', 'bool8', 'int16', 'int16', 'encodedString4096', 36 },
        --['onDisableCheckpoint'] = { 37 },
        ['onSetRaceCheckpoint'] = { 'int8', 'vector3d', 'vector3d', 'float', 38 },
        --['onDisableRaceCheckpoint'] = { 39 },
        --['onGamemodeRestart'] = { 40 },
        ['onPlayAudioStream'] = { 'string8', 'vector3d', 'float', 'bool8', 41 },
        --['onStopAudioStream'] = { 42 },
        ['onRemoveBuilding'] = { 'int32', 'vector3d', 'float', 43 },
        ['onCreateObject'] = { 44 },
        ['onSetObjectPosition'] = { 'int16', 'vector3d', 45 },
        ['onSetObjectRotation'] = { 'int16', 'vector3d', 46 },
        ['onDestroyObject'] = { 'int16', 47 },
        ['onPlayerDeathNotification'] = { 'int16', 'int16', 'int8', 55 },
        ['onSetMapIcon'] = { 'int8', 'vector3d', 'int8', 'int32', 'int8', 56 },
        ['onRemoveVehicleComponent'] = { 'int16', 'int16', 57 },
        ['onRemove3DTextLabel'] = { 'int16', 58 },
        ['onPlayerChatBubble'] = { 'int16', 'int32', 'float', 'int32', 'string8', 59 },
        ['onUpdateGlobalTimer'] = { 'int32', 60 },
        ['onShowDialog'] = { 'int16', 'int8', 'string8', 'string8', 'string8', 'encodedString4096', 61 },
        ['onDestroyPickup'] = { 'int32', 63 },
        ['onLinkVehicleToInterior'] = { 'int16', 'int8', 65 },
        ['onSetPlayerArmour'] = { 'float', 66 },
        ['onSetPlayerArmedWeapon'] = { 'int32', 67 },
        ['onSetSpawnInfo'] = { 'int8', 'int32', 'int8', 'vector3d', 'float', 'Int32Array3', 'Int32Array3', 68 },
        ['onSetPlayerTeam'] = { 'int16', 'int8', 69 },
        ['onPutPlayerInVehicle'] = { 'int16', 'int8', 70 },
        --['onRemovePlayerFromVehicle'] = { 71 },
        ['onSetPlayerColor'] = { 'int16', 'int32', 72 },
        ['onDisplayGameText'] = { 'int32', 'int32', 'string32', 73 },
        --['onForceClassSelection'] = { 74 },
        ['onAttachObjectToPlayer'] = { 'int16', 'int16', 'vector3d', 'vector3d', 75 },
        ['onInitMenu'] = { 76 },
        ['onShowMenu'] = { 'int8', 77 },
        ['onHideMenu'] = { 'int8', 78 },
        ['onCreateExplosion'] = { 'vector3d', 'int32', 'float', 79 },
        ['onShowPlayerNameTag'] = { 'int16', 'bool8', 80 },
        ['onAttachCameraToObject'] = { 'int16', 81 },
        ['onInterpolateCamera'] = { 'bool', 'vector3d', 'vector3d', 'int32', 'int8', 82 },
        ['onGangZoneStopFlash'] = { 'int16', 85 },
        ['onApplyPlayerAnimation'] = { 'int16', 'string8', 'string8', 'bool', 'bool', 'bool', 'bool', 'int32', 86 },
        ['onClearPlayerAnimation'] = { 'int16', 87 },
        ['onSetPlayerSpecialAction'] = { 'int8', 88 },
        ['onSetPlayerFightingStyle'] = { 'int16', 'int8', 89 },
        ['onSetPlayerVelocity'] = { 'vector3d', 90 },
        ['onSetVehicleVelocity'] = { 'bool8', 'vector3d', 91 },
        ['onServerMessage'] = { 'int32', 'string32', 93 },
        ['onSetWorldTime'] = { 'int8', 94 },
        ['onCreatePickup'] = { 'int32', 'int32', 'int32', 'vector3d', 95 },
        ['onMoveObject'] = { 'int16', 'vector3d', 'vector3d', 'float', 'vector3d', 99 },
        ['onEnableStuntBonus'] = { 'bool', 104 },
        ['onTextDrawSetString'] = { 'int16', 'string16', 105 },
        ['onSetCheckpoint'] = { 'vector3d', 'float', 107 },
        ['onCreateGangZone'] = { 'int16', 'vector2d', 'vector2d', 'int32', 108 },
        ['onPlayCrimeReport'] = { 'int16', 'int32', 'int32', 'int32', 'int32', 'vector3d', 112 },
        ['onGangZoneDestroy'] = { 'int16', 120 },
        ['onGangZoneFlash'] = { 'int16', 'int32', 121 },
        ['onStopObject'] = { 'int16', 122 },
        ['onSetVehicleNumberPlate'] = { 'int16', 'string8', 123 },
        ['onTogglePlayerSpectating'] = { 'bool32', 124 },
        ['onSpectatePlayer'] = { 'int16', 'int8', 126 },
        ['onSpectateVehicle'] = { 'int16', 'int8', 127 },
        ['onShowTextDraw'] = { 134 },
        ['onSetPlayerWantedLevel'] = { 'int8', 133 },
        ['onTextDrawHide'] = { 'int16', 135 },
        ['onRemoveMapIcon'] = { 'int8', 144 },
        ['onSetWeaponAmmo'] = { 'int8', 'int16', 145 },
        ['onSetGravity'] = { 'float', 146 },
        ['onSetVehicleHealth'] = { 'int16', 'float', 147 },
        ['onAttachTrailerToVehicle'] = { 'int16', 'int16', 148 },
        ['onDetachTrailerFromVehicle'] = { 'int16', 149 },
        ['onSetWeather'] = { 'int8', 152 },
        ['onSetPlayerSkin'] = { 'int32', 'int32', 153 },
        ['onSetInterior'] = { 'int8', 156 },
        ['onSetCameraPosition'] = { 'vector3d', 157 },
        ['onSetCameraLookAt'] = { 'vector3d', 'int8', 158 },
        ['onSetVehiclePosition'] = { 'int16', 'vector3d', 159 },
        ['onSetVehicleAngle'] = { 'int16', 'float', 160 },
        ['onSetVehicleParams'] = { 'int16', 'int16', 'bool8', 161 },
        --['onSetCameraBehind'] = { 162 },
        ['onChatMessage'] = { 'int16', 'string8', 101 },
        ['onConnectionRejected'] = { 'int8', 130 },
        ['onPlayerStreamOut'] = { 'int16', 163 },
        ['onVehicleStreamIn'] = { 164 },
        ['onVehicleStreamOut'] = { 'int16', 165 },
        ['onPlayerDeath'] = { 'int16', 166 },
        ['onPlayerEnterVehicle'] = { 'int16', 'int16', 'bool8', 26 },
        ['onUpdateScoresAndPings'] = { 'PlayerScorePingMap', 155 },
        ['onSetObjectMaterial'] = { 84 },
        ['onSetObjectMaterialText'] = { 84 },
        ['onSetVehicleParamsEx'] = { 'int16', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 24 },
        ['onSetPlayerAttachedObject'] = { 'int16', 'int32', 'bool', 'int32', 'int32', 'vector3d', 'vector3d', 'vector3d', 'int32', 'int32', 113 }

    }
    local handler_hook = {
        ['onInitGame'] = true,
        ['onCreateObject'] = true,
        ['onInitMenu'] = true,
        ['onShowTextDraw'] = true,
        ['onVehicleStreamIn'] = true,
        ['onSetObjectMaterial'] = true,
        ['onSetObjectMaterialText'] = true
    }
    local extra = {
        ['PlayerScorePingMap'] = true,
        ['Int32Array3'] = true
    }
    local hook_table = hooks[hook]
    if hook_table then
        local bs = raknetNewBitStream()
        if not handler_hook[hook] then
            local max = #hook_table-1
            if max > 0 then
                for i = 1, max do
                    local p = hook_table[i]
                    if extra[p] then extra_types[p]['write'](bs, parameters[i])
                    else bs_io[p]['write'](bs, parameters[i]) end
                end
            end
        else
            if hook == 'onInitGame' then handler.on_init_game_writer(bs, parameters)
            elseif hook == 'onCreateObject' then handler.on_create_object_writer(bs, parameters)
            elseif hook == 'onInitMenu' then handler.on_init_menu_writer(bs, parameters)
            elseif hook == 'onShowTextDraw' then handler.on_show_textdraw_writer(bs, parameters)
            elseif hook == 'onVehicleStreamIn' then handler.on_vehicle_stream_in_writer(bs, parameters)
            elseif hook == 'onSetObjectMaterial' then handler.on_set_object_material_writer(bs, parameters, 1)
            elseif hook == 'onSetObjectMaterialText' then handler.on_set_object_material_writer(bs, parameters, 2) end
        end
        raknetEmulRpcReceiveBitStream(hook_table[#hook_table], bs)
        raknetDeleteBitStream(bs)
    end
end

function ShowHelpMarker(desc)
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(450.0)
        imgui.TextUnformatted(desc)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function cmd_p()
	if not sampTextdrawIsExists(2112) then
		thread:run("p")
	end
	if sampTextdrawIsExists(2112) then
		sampSendClickTextdraw(2112)
	end
end
function cmd_p1()
	if not sampTextdrawIsExists(2103) then
		thread:run("p1")
	end
	if sampTextdrawIsExists(2103) then
		sampSendClickTextdraw(2103)
	end
end

function piar()
	act = not act
	if act then
			sampAddChatMessage(tag.. " {00FF7F}| {ffffff}Пиар включен", 0xFF1493)
	end
	lua_thread.create(function()
		if piaron1.v and piaron2.v and piaron3.v then
			if act then
				sampSendChat(u8:decode(piar1.v))
				wait(piartime.v * 1000)
				sampSendChat(u8:decode(piar2.v))
				wait(piartime.v * 1000)
				sampSendChat(u8:decode(piar3.v))
				wait(piartime.v * 1000)
				return true
			end
		end
		if piaron1.v and piaron2.v then
			if act then
				sampSendChat(u8:decode(piar1.v))
				wait(piartime.v * 1000)
				sampSendChat(u8:decode(piar2.v))
				wait(piartime.v * 1000)
				return true
			end
		end
		if piaron2.v and piaron3.v then
			if act then
				sampSendChat(u8:decode(piar2.v))
				wait(piartime.v * 1000)
				sampSendChat(u8:decode(piar3.v))
				wait(piartime.v * 1000)
				return true
			end
		end
		if piaron1.v and piaron3.v then
			if act then
				sampSendChat(u8:decode(piar1.v))
				wait(piartime.v * 1000)
				sampSendChat(u8:decode(piar3.v))
				wait(piartime.v * 1000)
				return true
			end
		end
		if piaron1.v then
			if act then
				sampSendChat(u8:decode(piar1.v))
				wait(piartime.v * 1000)
				return true
			end
		end
		if piaron2.v then
			if act then
				sampSendChat(u8:decode(piar2.v))
				wait(piartime.v * 1000)
				return true
			end
		end
		if piaron3.v then
			if act then
				sampSendChat(u8:decode(piar3.v))
				wait(piartime.v * 1000)
				return true
			end
		end
	end)
	if not act then
			sampAddChatMessage(tag.. " {00FF7F}| {ffffff}Пиар выключен", 0xFF1493)
	end
end

function checkip()
    local ip, port = sampGetCurrentServerAddress()
    for key, value in pairs(iparz) do
        if value == ip..':'..port then
            return true
        end
    end
    sampAddChatMessage(tag.. " {00FF7F}| {ffffff}Скрипт работает только для Reyes Family", 0xFF1493)
    lua_thread.create(function ()
        imgui.Process = false
        wait(100)
        thisScript():unload()
    end)
end

function hook.onDisplayGameText(style, time, text)
	if turbocontrol.v then
        if text:find("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~g~Comfort") then
            sampSendChat("/style")
        end
    end
	if fill.v then
			if text == '~w~This type of fuel ~r~ is not suitable~w~~n~ for your vehicles!' then
					sampSendClickTextdraw(18)
			end
			if text == '~w~' then
					sampSendClickTextdraw(2106)
					sampSendClickTextdraw(32)
			end
	end
end

function FishEye()
    while true do
        wait(0)
        if FishEyeEffect.v then
            if isCurrentCharWeapon(PLAYER_PED, 34) and isKeyDown(2) then
                if not locked then
                    cameraSetLerpFov(70.0, 70.0, 1000, 1)
                    locked = true
                end
            else
                cameraSetLerpFov(101.0, 101.0, 1000, 1)
                locked = false
            end
        end
    end
end

function hook.onServerMessage(color, text)
	if taks then
		if text:find("Вы получили") then
			sampSendClickTextdraw(2091)
		end
		return true
	end
	if one.v then
		if string.find(text, "__________Банковский чек__________") or string.find(text, "Для получения PayDay вы должны отыграть минимум 20 минут.") then
			thread:run("one")
		end
	end
	if two.v then
		if string.find(text, "__________Банковский чек__________") or string.find(text, "Для получения PayDay вы должны отыграть минимум 20 минут.") then
			thread:run("two")
		end
	end
	if turbocontrol.v then
		if string.find(text, "Этот транспорт зарегистрирован на жителя") then
			sampSendChat("/style")
		end
	end
	if repitvr.v then
		lua_thread.create(function()
				if text:find('После последнего сообщения в этом чате нужно подождать 3 секунды.') and not text:find("говорит:") then
					wait(500)
					sampSendChat(messvr)
				end
		end)
		if text:find('После последнего сообщения в этом чате нужно подождать 3 секунды.') and not text:find("говорит:") then
			return false
		end
	end
	if phone.v then
		if string.find(text, "Используйте клавишу (.-) для того, чтобы показать курсор управления или (.-) - скрыть") then
			if  window == 0 then
					ShowMessage('Вам позвонили на телефон', '', 0x10)
					return true
			end
			return true
		end
		return true
	end
end


function ShowMessage(text, title, style)
    ffi.cdef [[
        int MessageBoxA(
            void* hWnd,
            const char* lpText,
            const char* lpCaption,
            unsigned int uType

        );
    ]]
    local hwnd = ffi.cast('void*', readMemory(0x00C8CF88, 4, false))
    ffi.C.MessageBoxA(hwnd, text,  title, style and (style + 0x50000) or 0x50000)
end
ffi.cdef [[
    typedef int BOOL;
    typedef unsigned long HANDLE;
    typedef HANDLE HWND;
    typedef int bInvert;

    HWND GetActiveWindow(void);

    BOOL FlashWindow(HWND hWnd, BOOL bInvert);
]]

function hook.onSendCommand(mess)
	if mess:find('^/vr') then
		messvr = mess
    end
end

function hook.onPlayerChatBubble() if five.v then return false end end

function thread_function(one)
	if one == "one" then
		sampSendDialogResponse(966, 1, 9, false)
		wait(5000)
		sampSendClickTextdraw(2112)
	end
	if one == "two" then
		sampSendDialogResponse(966, 1, 9, false)
		wait(5000)
		sampSendClickTextdraw(2103)
	end
	if one == "p" then
		sampSendChat("/phone")
		wait(500)
		sampSendDialogResponse(1000, 1, 0 ,false)
		wait(500)
		sampSendClickTextdraw(2112)
	end
	if one == "p1" then
		sampSendChat("/phone")
		wait(500)
		sampSendDialogResponse(1000, 1, 0, false)
		wait(500)
		sampSendClickTextdraw(2103)
	end
end

function antipause()
		memory.setuint8(7634870, 1, false)
		memory.setuint8(7635034, 1, false)
		-- memory.fill(int address,int value,uint size,[bool unprotect=false])
		memory.fill(7623723, 144, 8, false)
		memory.fill(5499528, 144, 6, false)
end

function stok_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    style.WindowRounding = 2
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 3
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0
    style.WindowPadding = imgui.ImVec2(4.0, 4.0)
    style.FramePadding = imgui.ImVec2(3.5, 3.5)
    style.ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
    colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
    colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
    colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
    colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
    colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
    colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
    colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
    colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
    colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
    colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
    colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
    colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
    colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
    colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
    colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
    colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
    colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
    colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
    colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
    colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
    colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end

function apply_custom_style()
	imgui.SwitchContext()
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
local ImVec2 = imgui.ImVec2

style.WindowPadding = ImVec2(15, 15)
style.WindowRounding = 6.0
style.FramePadding = ImVec2(5, 5)
style.FrameRounding = 4.0
style.ItemSpacing = ImVec2(12, 8)
style.ItemInnerSpacing = ImVec2(8, 6)
style.IndentSpacing = 25.0
style.ScrollbarSize = 15.0
style.ScrollbarRounding = 9.0
style.GrabMinSize = 5.0
style.GrabRounding = 3.0

colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
--helperLovli
function lightBlue()
	imgui.SwitchContext()
     local style = imgui.GetStyle()
     local colors = style.Colors
     local clr = imgui.Col
     local ImVec4 = imgui.ImVec4

     style.WindowRounding = 2.0
     style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
     style.ChildWindowRounding = 2.0
     style.FrameRounding = 2.0
     style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
     style.ScrollbarSize = 13.0
     style.ScrollbarRounding = 0
     style.GrabMinSize = 8.0
     style.GrabRounding = 1.0

     colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
     colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
     colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
     colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
     colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
     colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
     colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
     colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
     colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
     colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 0.40)
     colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
     colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
     colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
     colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
     colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
     colors[clr.Separator]              = colors[clr.Border]
     colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
     colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
     colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
     colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
     colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
     colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
     colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
     colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
     colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
     colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
     colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
     colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
     colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
     colors[clr.ComboBg]                = colors[clr.PopupBg]
     colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
     colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
     colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
     colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
     colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
     colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
     colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
     colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
     colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
     colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
     colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
     colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
     colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
 end

function redTheme()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowRounding = 2.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0

	colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
	colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
	colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
	colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
	colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function onReceiveRpc(id, bs)
    if TThide.v and supreme.v then
		if id == 44 then
			raknetBitStreamIgnoreBits(bs, 16)
			local modelId = raknetBitStreamReadInt32(bs)
			raknetBitStreamIgnoreBits(bs, 232)
			local attachToVehicleId = raknetBitStreamReadInt16(bs)
			if modelId == 19476 and attachToVehicleId ~= 0xFFFF then
				return false
			end
			if modelId == 19327 and attachToVehicleId ~= 0xFFFF then
				return false
			end
		end 
	end
	if supreme.v and not TThide.v then
		if id == 44 then
			raknetBitStreamIgnoreBits(bs, 16)
			local modelId = raknetBitStreamReadInt32(bs)
			raknetBitStreamIgnoreBits(bs, 232)
			local attachToVehicleId = raknetBitStreamReadInt16(bs)
			if modelId == 19476 and attachToVehicleId ~= 0xFFFF then
				return false
			end
		end 
	end
	if TThide.v and not supreme.v then
		if id == 44 then
			raknetBitStreamIgnoreBits(bs, 16)
			local modelId = raknetBitStreamReadInt32(bs)
			raknetBitStreamIgnoreBits(bs, 232)
			local attachToVehicleId = raknetBitStreamReadInt16(bs)
			if modelId == 19327 and attachToVehicleId ~= 0xFFFF then
				return false
			end
		end 
	end
end


function hook.onShowDialog(id, style, title, button1, button1, text)
	if taks then
		if sampTextdrawIsExists(2091) then
			if text:find("Поздравляем с получением:") then
				sampSendClickTextdraw(2091)
			end
			return true
		end
	end
	if enter.v and text:find("Этот транспорт продается.") then
		sampSendDialogResponse(11, 1, 0, false)
	end
	if fh.v and text:find("1. Дом") then
		if text:find("ID: {C9B931}125") and dirMusic ~= nil then
        setAudioStreamState(dirMusic, as_action.PLAY)
        setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}146") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}219") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}318") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}319") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}320") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}321") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}322") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}323") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}324") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}325") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}337") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}359") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}360") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}361") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}362") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}363") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}358") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}378") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}424") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}425") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}426") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}427") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}428") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}429") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}435") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}438") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}442") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}444") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}448") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}457") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}499") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}516") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}533") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}542") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}544") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}550") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}566") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}569") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}590") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}598") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}609") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}621") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}622") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}623") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}629") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}658") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}660") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}666") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}715") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}784") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}804") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}849") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}856") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}857") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}858") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}859") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}860") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}880") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}881") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}882") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}883") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}888") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}897") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}898") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}899") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}936") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}996") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1059") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1060") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1061") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1062") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1063") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1064") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1065") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1066") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1067") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1068") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1069") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1070") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1071") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1072") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
		if text:find("ID: {C9B931}1073") and dirMusic ~= nil then
				setAudioStreamState(dirMusic, as_action.PLAY)
				setAudioStreamVolume(dirMusic, 50)
		end
	end
end

function cmd_h(arg)
	sampSendChat("/findihouse " .. arg)
	if #arg == 0 then
    sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Вы ничего не ввели (0-1140)", 0xFFFFFF)
	else
		if tonumber(arg) <= 0 and tonumber(arg) >= 0 then
			sampAddChatMessage("{8A2BE2}[Forum House]: {FFFFFF}Maze Bank", 0xFFFFFF)
		end
		if tonumber(arg) <= 1 and tonumber(arg) >= 1 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН", 0xFFFFFF)
		end
		if tonumber(arg) <= 4 and tonumber(arg) >= 2 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Баллас", 0xFFFFFF)
		end
		if tonumber(arg) <= 6 and tonumber(arg) >= 5 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Особа за пиццерией", 0xFFFFFF)
		end
		if tonumber(arg) <= 14 and tonumber(arg) >= 7 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Баллас", 0xFFFFFF)
		end
		if tonumber(arg) <= 31 and tonumber(arg) >= 15 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Район 20-х", 0xFFFFFF)
		end
		if tonumber(arg) <= 38 and tonumber(arg) > 31 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ночные Волки", 0xFFFFFF)
			end
		if tonumber(arg) <= 44 and tonumber(arg) >= 39 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ночные Волки", 0xFFFFFF)
		end
		if tonumber(arg) <= 45 and tonumber(arg) >= 45 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ночные Волки", 0xFFFFFF)
		end
		if tonumber(arg) <= 51 and tonumber(arg) > 45 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Район 50-х", 0xFFFFFF)
		end
		if tonumber(arg) <= 52 and tonumber(arg) >= 52 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 57 and tonumber(arg) >= 53 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Район 50-х", 0xFFFFFF)
	end
	if tonumber(arg) <= 81 and tonumber(arg) > 57 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Грувы", 0xFFFFFF)
	end
	if tonumber(arg) <= 93 and tonumber(arg) > 81 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Рифа Район 80-х", 0xFFFFFF)
	end
	if tonumber(arg) <= 101 and tonumber(arg) > 93 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дальние Ацтеки", 0xFFFFFF)
	end
	if tonumber(arg) <= 109 and tonumber(arg) > 101 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ацтеки", 0xFFFFFF)
	end
	if tonumber(arg) <= 112 and tonumber(arg) >= 110 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Квартира между Рифой и Ацтеками", 0xFFFFFF)
	end
	if tonumber(arg) <= 115 and tonumber(arg) >= 113 then
		sampAddChatMessage("{8A2BE2}[House Garage]: {FFFFFF}Особняк между Рифой и Ацтеками", 0xFFFFFF)
	end
	if tonumber(arg) <= 122 and tonumber(arg) > 115 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЖДЛС", 0xFFFFFF)
	end
	if tonumber(arg) <= 124 and tonumber(arg) > 122 then
		sampAddChatMessage("{8A2BE2}[House Garage]: {FFFFFF}Аэропорт ЛС", 0xFFFFFF)
	end
	if tonumber(arg) <= 125 and tonumber(arg) >= 125 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 141 and tonumber(arg) >= 126 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Аэропорт ЛС", 0xFFFFFF)
	end
	if tonumber(arg) <= 145 and tonumber(arg) > 141 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 146 and tonumber(arg) >= 146 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Хата Филата в Центре ЛС", 0xFFFFFF)
	end
	if tonumber(arg) <= 157 and tonumber(arg) > 147 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 161 and tonumber(arg) > 157 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 168 and tonumber(arg) >= 162 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Санта Мария повёрнутая задом", 0xFFFFFF)
	end
	if tonumber(arg) <= 170 and tonumber(arg) >= 169 then
		sampAddChatMessage("{8A2BE2}[House Garage]: {FFFFFF}Санта Мария повёрнутая задом", 0xFFFFFF)
	end
	if tonumber(arg) <= 190 and tonumber(arg) > 170 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Канал Санта Марии", 0xFFFFFF)
	end
	if tonumber(arg) <= 196 and tonumber(arg) > 190 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Санта Санта Мария", 0xFFFFFF)
	end
	if tonumber(arg) <= 218 and tonumber(arg) > 196 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ВайнВуд", 0xFFFFFF)
	end
	if tonumber(arg) <= 219 and tonumber(arg) >= 219 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Деревяшка в Лас-Вентурас", 0xFFFFFF)
	end
	if tonumber(arg) <= 246 and tonumber(arg) >= 220 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ВайнВуд", 0xFFFFFF)
	end
	if tonumber(arg) <= 247 and tonumber(arg) >= 247 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 248 and tonumber(arg) >= 248 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 249 and tonumber(arg) >= 249 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 250 and tonumber(arg) >= 250 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 251 and tonumber(arg) >= 251 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 252 and tonumber(arg) >= 252 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 254 and tonumber(arg) >= 253 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 255 and tonumber(arg) >= 255 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Гора Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 256 and tonumber(arg) >= 256 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
  end
	if tonumber(arg) <= 258 and tonumber(arg) >= 257 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Гора Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 259 and tonumber(arg) >= 259 then
		sampAddChatMessage("{8A2BE2}[House Garage]: {FFFFFF}Гора Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 262 and tonumber(arg) >= 260 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 263 and tonumber(arg) >= 263 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на Ферме", 0xFFFFFF)
	end
	if tonumber(arg) <= 264 and tonumber(arg) >= 264 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Голубая Коробка в Гетто", 0xFFFFFF)
	end
	if tonumber(arg) <= 265 and tonumber(arg) >= 265 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у СТО", 0xFFFFFF)
	end
	if tonumber(arg) <= 269 and tonumber(arg) >= 266 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 274 and tonumber(arg) >= 270 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Квадратная Коробка на Вагосах", 0xFFFFFF)
	end
	if tonumber(arg) <= 278 and tonumber(arg) >= 275 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на Вагосах", 0xFFFFFF)
	end
	if tonumber(arg) <= 279 and tonumber(arg) >= 279 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Гора Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 282 and tonumber(arg) >= 280 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 283 and tonumber(arg) >= 283 then
		sampAddChatMessage("{8A2BE2}[House Garage]: {FFFFFF}Гора Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 284 and tonumber(arg) >= 284 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на Вагосах", 0xFFFFFF)
	end
	if tonumber(arg) <= 286 and tonumber(arg) >= 285 then
		sampAddChatMessage("{8A2BE2}[House Garage]: {FFFFFF}Гора Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 292 and tonumber(arg) >= 287 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на Вагосах", 0xFFFFFF)
	end
	if tonumber(arg) <= 295 and tonumber(arg) >= 293 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Голубая Коробка Гетто", 0xFFFFFF)
	end
	if tonumber(arg) <= 305 and tonumber(arg) >= 296 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Под Горой Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 308 and tonumber(arg) >= 306 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Фон Аватарки Леонардо", 0xFFFFFF)
	end
	if tonumber(arg) <= 309 and tonumber(arg) >= 309 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у СТО", 0xFFFFFF)
	end
	if tonumber(arg) <= 310 and tonumber(arg) >= 310 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 311 and tonumber(arg) >= 311 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у СТО", 0xFFFFFF)
	end
	if tonumber(arg) <= 315 and tonumber(arg) >= 312 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Фон Аватарки Леонардо", 0xFFFFFF)
	end
	if tonumber(arg) <= 317 and tonumber(arg) >= 316 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 325 and tonumber(arg) >= 318 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}РКШД", 0xFFFFFF)
	end
	if tonumber(arg) <= 330 and tonumber(arg) >= 326 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у Фермы", 0xFFFFFF)
	end
	if tonumber(arg) <= 336 and tonumber(arg) >= 331 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Яма между Фермой и Монтгомери", 0xFFFFFF)
	end
	if tonumber(arg) <= 337 and tonumber(arg) >= 337 then
		sampAddChatMessage("{8A2BE2}[Forum House]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 344 and tonumber(arg) >= 338 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Яма между Фермой и Монтгомери", 0xFFFFFF)
	end
	if tonumber(arg) <= 357 and tonumber(arg) >= 345 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF} ВайнВуд", 0xFFFFFF)
	end
	if tonumber(arg) <= 358 and tonumber(arg) >= 358 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Филат", 0xFFFFFF)
	end
	if tonumber(arg) <= 360 and tonumber(arg) >= 359 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Концертный Зал", 0xFFFFFF)
	end
	if tonumber(arg) <= 363 and tonumber(arg) >= 361 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Особняк за АММО Санта Марии", 0xFFFFFF)
	end
	if tonumber(arg) <= 364 and tonumber(arg) >= 364 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Больница ЛС", 0xFFFFFF)
	end
	if tonumber(arg) <= 365 and tonumber(arg) >= 365 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у СТО", 0xFFFFFF)
	end
	if tonumber(arg) <= 366 and tonumber(arg) >= 366 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Больница ЛС", 0xFFFFFF)
	end
	if tonumber(arg) <= 367 and tonumber(arg) >= 367 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у СТО", 0xFFFFFF)
	end
	if tonumber(arg) <= 373 and tonumber(arg) >= 368 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Больница ЛС", 0xFFFFFF)
	end
	if tonumber(arg) <= 377 and tonumber(arg) >= 374 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 378 and tonumber(arg) >= 378 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом Мед Дога", 0xFFFFFF)
	end
	if tonumber(arg) <= 391 and tonumber(arg) >= 379 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 392 and tonumber(arg) >= 392 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 394 and tonumber(arg) >= 393 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 395 and tonumber(arg) >= 395 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 400 and tonumber(arg) >= 396 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 401 and tonumber(arg) >= 401 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 404 and tonumber(arg) >= 402 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 423 and tonumber(arg) >= 405 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка Монтгомери", 0xFFFFFF)
	end
	if tonumber(arg) <= 429 and tonumber(arg) >= 424 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом у СТО", 0xFFFFFF)
	end
	if tonumber(arg) <= 431 and tonumber(arg) >= 430 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у Фермы", 0xFFFFFF)
	end
	if tonumber(arg) <= 432 and tonumber(arg) >= 432 then
		sampAddChatMessage("{8A2BE2}[House Garage]: {FFFFFF}Гора Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 434 and tonumber(arg) >= 433 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на горе Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 435 and tonumber(arg) >= 435 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Гора РКПД", 0xFFFFFF)
	end
	if tonumber(arg) <= 437 and tonumber(arg) >= 436 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Голубая Коробка на берегу гетто", 0xFFFFFF)
	end
	if tonumber(arg) <= 438 and tonumber(arg) >= 438 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Гора РКПД", 0xFFFFFF)
	end
	if tonumber(arg) <= 440 and tonumber(arg) >= 439 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Паломино Крик", 0xFFFFFF)
	end
	if tonumber(arg) <= 441 and tonumber(arg) >= 441 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на горе Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 442 and tonumber(arg) >= 442 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 443 and tonumber(arg) >= 443 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на горе Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 444 and tonumber(arg) >= 444 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом над Автобазаром", 0xFFFFFF)
	end
	if tonumber(arg) <= 447 and tonumber(arg) >= 445 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на горе Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 448 and tonumber(arg) >= 448 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 449 and tonumber(arg) >= 449 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка на горе Вагос", 0xFFFFFF)
	end
	if tonumber(arg) <= 456 and tonumber(arg) >= 450 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 457 and tonumber(arg) >= 457 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 460 and tonumber(arg) >= 458 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 461 and tonumber(arg) >= 461 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 475 and tonumber(arg) >= 462 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 476 and tonumber(arg) >= 476 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 493 and tonumber(arg) >= 477 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 498 and tonumber(arg) >= 494 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Больница ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 499 and tonumber(arg) >= 499 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом на Санте за 40кк", 0xFFFFFF)
	end
	if tonumber(arg) <= 515 and tonumber(arg) >= 500 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Больница ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 516 and tonumber(arg) >= 516 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 525 and tonumber(arg) >= 517 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Больница ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 532 and tonumber(arg) >= 526 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН часть у АЗС", 0xFFFFFF)
	end
	if tonumber(arg) <= 533 and tonumber(arg) >= 533 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ВайнВуд", 0xFFFFFF)
	end
	if tonumber(arg) <= 541 and tonumber(arg) >= 534 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН часть у АЗС", 0xFFFFFF)
	end
	if tonumber(arg) <= 542 and tonumber(arg) >= 542 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 543 and tonumber(arg) >= 543 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН часть у АЗС", 0xFFFFFF)
	end
	if tonumber(arg) <= 544 and tonumber(arg) >= 544 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ВайнВуд", 0xFFFFFF)
	end
	if tonumber(arg) <= 549 and tonumber(arg) >= 545 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Форт Карсон", 0xFFFFFF)
	end
	if tonumber(arg) <= 550 and tonumber(arg) >= 550 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
		end
		if tonumber(arg) <= 565 and tonumber(arg) >= 551 then
			sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Форт Карсоне", 0xFFFFFF)
		end
		if tonumber(arg) <= 566 and tonumber(arg) >= 566 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Кладбище", 0xFFFFFF)
		end
		if tonumber(arg) <= 568 and tonumber(arg) >= 567 then
			sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Форт Карсоне", 0xFFFFFF)
		end
		if tonumber(arg) <= 569 and tonumber(arg) >= 569 then
			sampAddChatMessage("{8A2BE2}[Forum House]: {FFFFFF}Замок у СФ салона", 0xFFFFFF)
		end
		if tonumber(arg) <= 571 and tonumber(arg) >= 570 then
			sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Форт Карсоне", 0xFFFFFF)
		end
	if tonumber(arg) <= 581 and tonumber(arg) >= 572 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у заброшенного аэропорта", 0xFFFFFF)
	end
	if tonumber(arg) <= 582 and tonumber(arg) >= 582 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 585 and tonumber(arg) >= 583 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка у заброшенного аэропорта", 0xFFFFFF)
	end
	if tonumber(arg) <= 589 and tonumber(arg) >= 586 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Гора у дома Мистгана", 0xFFFFFF)
	end
	if tonumber(arg) <= 590 and tonumber(arg) >= 590 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом Мистгана", 0xFFFFFF)
	end
	if tonumber(arg) <= 597 and tonumber(arg) >= 591 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Эль Куебрадос", 0xFFFFFF)
	end
	if tonumber(arg) <= 598 and tonumber(arg) >= 598 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 602 and tonumber(arg) >= 599 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Эль Куебрадос", 0xFFFFFF)
	end
	if tonumber(arg) <= 603 and tonumber(arg) >= 603 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 607 and tonumber(arg) >= 604 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Эль Куебрадос", 0xFFFFFF)
	end
	if tonumber(arg) <= 608 and tonumber(arg) >= 608 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Лас Баранкас", 0xFFFFFF)
	end
	if tonumber(arg) <= 609 and tonumber(arg) >= 609 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Одиночка Мёдика", 0xFFFFFF)
	end
	if tonumber(arg) <= 620 and tonumber(arg) >= 610 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Лас Баранкас", 0xFFFFFF)
	end
	if tonumber(arg) <= 621 and tonumber(arg) >= 621 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Времянка с Форумным гаражом в Лас Баранкас", 0xFFFFFF)
	end
	if tonumber(arg) <= 622 and tonumber(arg) >= 622 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Одиночка Данте/Эрнесто/Леонардо", 0xFFFFFF)
	end
	if tonumber(arg) <= 623 and tonumber(arg) >= 623 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Одиночка Морковки", 0xFFFFFF)
	end
	if tonumber(arg) <= 627 and tonumber(arg) >= 624 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Яме Форт Карсона", 0xFFFFFF)
	end
	if tonumber(arg) <= 628 and tonumber(arg) >= 628 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Форт Карсон", 0xFFFFFF)
	end
	if tonumber(arg) <= 629 and tonumber(arg) >= 629 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом Культуры Форт Карсон", 0xFFFFFF)
	end
	if tonumber(arg) <= 640 and tonumber(arg) >= 630 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Форт Карсон", 0xFFFFFF)
	end
	if tonumber(arg) <= 641 and tonumber(arg) >= 641 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН", 0xFFFFFF)
	end
	if tonumber(arg) <= 642 and tonumber(arg) >= 642 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 645 and tonumber(arg) >= 643 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 650 and tonumber(arg) >= 646 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 651 and tonumber(arg) >= 651 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 652 and tonumber(arg) >= 652 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 653 and tonumber(arg) >= 653 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 655 and tonumber(arg) >= 654 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 656 and tonumber(arg) >= 656 then
		sampAddChatMessage("{8A2BE2}[Room]: {FFFFFF}Таможня", 0xFFFFFF)
	end
	if tonumber(arg) <= 657 and tonumber(arg) >= 657 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Автосалон ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 658 and tonumber(arg) >= 658 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 659 and tonumber(arg) >= 659 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Автосалон ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 660 and tonumber(arg) >= 660 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Green Town", 0xFFFFFF)
	end
	if tonumber(arg) <= 665 and tonumber(arg) >= 661 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Автосалон ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 666 and tonumber(arg) >= 666 then
		sampAddChatMessage("{8A2BE2}[Forum House]: {FFFFFF}Кольцо ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 679 and tonumber(arg) >= 667 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Автосалон ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 680 and tonumber(arg) >= 680 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 683 and tonumber(arg) >= 681 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Автосалон ЛВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 684 and tonumber(arg) >= 684 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 714 and tonumber(arg) >= 685 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН", 0xFFFFFF)
	end
	if tonumber(arg) <= 715 and tonumber(arg) >= 715 then
		sampAddChatMessage("{8A2BE2}[Forum House]: {FFFFFF}Форумная особа у АЗС под ВВ", 0xFFFFFF)
	end
	if tonumber(arg) <= 731 and tonumber(arg) >= 716 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН", 0xFFFFFF)
	end
	if tonumber(arg) <= 735 and tonumber(arg) >= 732 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Пляж в СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 736 and tonumber(arg) >= 736 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Автосалон СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 744 and tonumber(arg) >= 737 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Пляж в СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 752 and tonumber(arg) >= 745 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Особа у Больницы СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 783 and tonumber(arg) >= 753 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Больница СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 784 and tonumber(arg) >= 784 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Обсерватория", 0xFFFFFF)
	end
	if tonumber(arg) <= 794 and tonumber(arg) >= 785 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Больница СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 803 and tonumber(arg) >= 795 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 804 and tonumber(arg) >= 804 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Одиночка у Автосалона СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 805 and tonumber(arg) >= 805 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 831 and tonumber(arg) >= 806 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Автосалон СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 833 and tonumber(arg) >= 832 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 1", 0xFFFFFF)
	end
	if tonumber(arg) <= 834 and tonumber(arg) >= 834 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 2", 0xFFFFFF)
	end
	if tonumber(arg) <= 838 and tonumber(arg) >= 835 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 1", 0xFFFFFF)
	end
	if tonumber(arg) <= 839 and tonumber(arg) >= 839 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 2", 0xFFFFFF)
	end
	if tonumber(arg) <= 840 and tonumber(arg) >= 840 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 1", 0xFFFFFF)
	end
	if tonumber(arg) <= 841 and tonumber(arg) >= 841 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 2", 0xFFFFFF)
	end
	if tonumber(arg) <= 842 and tonumber(arg) >= 842 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 1", 0xFFFFFF)
	end
	if tonumber(arg) <= 844 and tonumber(arg) >= 843 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 2", 0xFFFFFF)
	end
	if tonumber(arg) <= 845 and tonumber(arg) >= 845 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 1", 0xFFFFFF)
	end
	if tonumber(arg) <= 848 and tonumber(arg) >= 846 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 2", 0xFFFFFF)
	end
	if tonumber(arg) <= 849 and tonumber(arg) >= 849 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Одиночка Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 852 and tonumber(arg) >= 850 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 2", 0xFFFFFF)
	end
	if tonumber(arg) <= 853 and tonumber(arg) >= 853 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды с х5 гаражом", 0xFFFFFF)
	end
	if tonumber(arg) <= 855 and tonumber(arg) >= 854 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}СФ из воды 2", 0xFFFFFF)
	end
	if tonumber(arg) <= 856 and tonumber(arg) >= 856 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом Дракулы на Болоте", 0xFFFFFF)
	end
	if tonumber(arg) <= 857 and tonumber(arg) >= 857 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Дом Дракулы", 0xFFFFFF)
	end
	if tonumber(arg) <= 858 and tonumber(arg) >= 858 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Верхний Чиллиад", 0xFFFFFF)
	end
	if tonumber(arg) <= 859 and tonumber(arg) >= 859 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Нижний Чиллиад", 0xFFFFFF)
	end
	if tonumber(arg) <= 860 and tonumber(arg) >= 860 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Новогодняя Особа над Автобазаром", 0xFFFFFF)
	end
	if tonumber(arg) <= 879 and tonumber(arg) >= 861 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Военный городок", 0xFFFFFF)
	end
	if tonumber(arg) <= 883 and tonumber(arg) >= 880 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Особа на пляжу гетто", 0xFFFFFF)
	end
	if tonumber(arg) <= 887 and tonumber(arg) >= 884 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Ангел Пайн", 0xFFFFFF)
	end
		if tonumber(arg) <= 888 and tonumber(arg) >= 888 then
		sampAddChatMessage("{8A2BE2}[Forum House]: {FFFFFF}Ухо ЛВ", 0xFFFFFF)
	end
		if tonumber(arg) <= 895 and tonumber(arg) >= 889 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Ангел Пайн", 0xFFFFFF)
	end
	if tonumber(arg) <= 896 and tonumber(arg) >= 896 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 899 and tonumber(arg) >= 897 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Змейка Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 935 and tonumber(arg) >= 900 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 936 and tonumber(arg) >= 936 then
		sampAddChatMessage("{8A2BE2}[Conor House]: {FFFFFF}Санта Мария", 0xFFFFFF)
	end
	if tonumber(arg) <= 944 and tonumber(arg) >= 937 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 953 and tonumber(arg) >= 945 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Уголок у АЗС СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 971 and tonumber(arg) >= 954 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 979 and tonumber(arg) >= 972 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тиерра Робада", 0xFFFFFF)
	end
	if tonumber(arg) <= 985 and tonumber(arg) >= 980 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Тиерре Робаде", 0xFFFFFF)
	end
	if tonumber(arg) <= 988 and tonumber(arg) >= 986 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Гора Эль Куебрадос", 0xFFFFFF)
	end
	if tonumber(arg) <= 990 and tonumber(arg) >= 989 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Эль Куебрадос", 0xFFFFFF)
	end
	if tonumber(arg) <= 995 and tonumber(arg) >= 991 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Времянка в Лас Баранкас", 0xFFFFFF)
	end
	if tonumber(arg) <= 996 and tonumber(arg) >= 996 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Одиночка у Карьера", 0xFFFFFF)
	end
	if tonumber(arg) <= 999 and tonumber(arg) >= 997 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 1001 and tonumber(arg) >= 1000 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро не плохое", 0xFFFFFF)
	end
	if tonumber(arg) <= 1002 and tonumber(arg) >= 1002 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 1004 and tonumber(arg) >= 1003 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 1009 and tonumber(arg) >= 1005 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Уголок у АЗС в СФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 1010 and tonumber(arg) >= 1010 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Топ хата напротив Аренды за БСФ", 0xFFFFFF)
	end
	if tonumber(arg) <= 1011 and tonumber(arg) >= 1011 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Будки для собак", 0xFFFFFF)
	end
	if tonumber(arg) <= 1016 and tonumber(arg) >= 1012 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Будки для собак", 0xFFFFFF)
	end
	if tonumber(arg) <= 1030 and tonumber(arg) >= 1017 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро ближе к Джиззи", 0xFFFFFF)
	end
	if tonumber(arg) <= 1038 and tonumber(arg) >= 1031 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 1039 and tonumber(arg) >= 1039 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Сан-Фиерро без гаража", 0xFFFFFF)
	end
	if tonumber(arg) <= 1040 and tonumber(arg) >= 1040 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 1043 and tonumber(arg) >= 1041 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Сан-Фиерро в подворотне без гаража", 0xFFFFFF)
	end
	if tonumber(arg) <= 1045 and tonumber(arg) >= 1044 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро на обрыве", 0xFFFFFF)
	end
	if tonumber(arg) <= 1046 and tonumber(arg) >= 1046 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Сан-Фиерро без гаража возле Перфоманса", 0xFFFFFF)
	end
	if tonumber(arg) <= 1047 and tonumber(arg) >= 1047 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро возле Перфоманса", 0xFFFFFF)
	end
	if tonumber(arg) <= 1048 and tonumber(arg) >= 1048 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Сан-Фиерро без гаража возле Перфоманса", 0xFFFFFF)
	end
	if tonumber(arg) <= 1050 and tonumber(arg) >= 1049 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро возле Перфоманса", 0xFFFFFF)
	end
	if tonumber(arg) <= 1052 and tonumber(arg) >= 1051 then
		sampAddChatMessage("{8A2BE2}[House Garage x3]: {FFFFFF}Сан-Фиерро возле берега", 0xFFFFFF)
	end
	if tonumber(arg) <= 1053 and tonumber(arg) >= 1053 then
		sampAddChatMessage("{8A2BE2}[Trash]: {FFFFFF}Сан-Фиерро в подворотне", 0xFFFFFF)
	end
	if tonumber(arg) <= 1058 and tonumber(arg) >= 1054 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Сан-Фиерро", 0xFFFFFF)
	end
	if tonumber(arg) <= 1061 and tonumber(arg) >= 1059 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Palomino Hills с причалом", 0xFFFFFF)
	end
	if tonumber(arg) <= 1062 and tonumber(arg) >= 1062 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Palomino Hills у берега (Текстура из Тиерры)", 0xFFFFFF)
	end
	if tonumber(arg) <= 1063 and tonumber(arg) >= 1063 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Коробка в Palomino Hills", 0xFFFFFF)
	end
	if tonumber(arg) <= 1068 and tonumber(arg) >= 1064 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Palomino Hills", 0xFFFFFF)
	end
	if tonumber(arg) <= 1069 and tonumber(arg) >= 1069 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Тарелка в Palomino Hills", 0xFFFFFF)
	end
	if tonumber(arg) <= 1070 and tonumber(arg) >= 1070 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Кастрюля в Palomino Hills", 0xFFFFFF)
	end
	if tonumber(arg) <= 1071 and tonumber(arg) >= 1071 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Palomino Hills", 0xFFFFFF)
	end
	if tonumber(arg) <= 1072 and tonumber(arg) >= 1072 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Palomino Hills (Любимая Леонардо)", 0xFFFFFF)
	end
	if tonumber(arg) <= 1073 and tonumber(arg) >= 1073 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Palomino Hills (Топ 2 у Леонардо)", 0xFFFFFF)
	end
	if tonumber(arg) <= 1108 and tonumber(arg) >= 1074 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЖК Signature", 0xFFFFFF)
	end
	if tonumber(arg) <= 1140 and tonumber(arg) >= 1109 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Los Santos Tower", 0xFFFFFF)
	end
		if tonumber(arg) >= 1141 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Use /h 0-1140", 0xFFFFFF)
		end
		if tonumber(arg) < 0 then
			sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}Use /h 0-1140", 0xFFFFFF)
		end
	end
end

function cmd_b(arg)
	sampSendChat("/findibiz " .. arg)
	if #arg == 0 then
		sampAddChatMessage("[Business]: {FFFFFF}Вы ничего не ввели (0-253)", 0x6495ED)
	else
		if tonumber(arg) == 0 then
			sampAddChatMessage("[Business]: {FFFFFF}АММО ЛС", 0x6495ED)
		end
		if tonumber(arg) == 1 then
			sampAddChatMessage("[Business]: {FFFFFF}АММО ПК", 0x6495ED)
		end
		if tonumber(arg) == 2 then
			sampAddChatMessage("[Business]: {FFFFFF}АММО у Фермы", 0x6495ED)
		end
		if tonumber(arg) == 3 then
			sampAddChatMessage("[Business]: {FFFFFF}Бар Пиг Пен", 0x6495ED)
		end
		if tonumber(arg) == 4 then
			sampAddChatMessage("[Business]: {FFFFFF}Бар Альхамбра", 0x6495ED)
		end
		if tonumber(arg) == 5 then
			sampAddChatMessage("[Business]: {FFFFFF}Бар 3 Бутылки", 0x6495ED)
		end
		if tonumber(arg) == 6 then
			sampAddChatMessage("[Business]: {FFFFFF}24/7 ЦБ", 0x6495ED)
		end
		if tonumber(arg) == 7 then
			sampAddChatMessage("[Business]: {FFFFFF}24/7 под ВВ", 0x6495ED)
		end
		if tonumber(arg) == 8 then
			sampAddChatMessage("[Business]: {FFFFFF}24/7 Баллас", 0x6495ED)
		end
		if tonumber(arg) == 9 then
			sampAddChatMessage("[Business]: {FFFFFF}24/7 на Грувах", 0x6495ED)
		end
		if tonumber(arg) == 10 then
			sampAddChatMessage("[Business]: {FFFFFF}24/7 ЖДЛС", 0x6495ED)
		end
		if tonumber(arg) <= 11 and tonumber(arg) >= 11 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 у Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 12 and tonumber(arg) >= 12 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО РКШД", 0x6495ED)
		end
		if tonumber(arg) <= 13 and tonumber(arg) >= 13 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО Гетто", 0x6495ED)
		end
		if tonumber(arg) <= 14 and tonumber(arg) >= 14 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО в Центре ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 15 and tonumber(arg) >= 15 then
		  sampAddChatMessage("[Business]: {FFFFFF}Предприятие Ферма", 0x6495ED)
		end
		if tonumber(arg) <= 16 and tonumber(arg) >= 16 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 ЛС-СФ", 0x6495ED)
		end
		if tonumber(arg) <= 17 and tonumber(arg) >= 17 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Ангел Пайн", 0x6495ED)
		end
		if tonumber(arg) <= 18 and tonumber(arg) >= 18 then
		  sampAddChatMessage("[Business]: {FFFFFF}Error", 0x6495ED)
		end
		if tonumber(arg) <= 19 and tonumber(arg) >= 19 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС под ВВ", 0x6495ED)
		end
		if tonumber(arg) <= 20 and tonumber(arg) >= 20 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Гетто", 0x6495ED)
		end
		if tonumber(arg) <= 21 and tonumber(arg) >= 21 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС ЛС-СФ", 0x6495ED)
		end
		if tonumber(arg) <= 22 and tonumber(arg) >= 22 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Байкеры 2", 0x6495ED)
		end
		if tonumber(arg) <= 23 and tonumber(arg) >= 23 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС ЖДСФ", 0x6495ED)
		end
		if tonumber(arg) <= 24 and tonumber(arg) >= 24 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Больница СФ", 0x6495ED)
		end
		if tonumber(arg) <= 25 and tonumber(arg) >= 25 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Байкеры 1", 0x6495ED)
		end
		if tonumber(arg) <= 26 and tonumber(arg) >= 26 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС СФа", 0x6495ED)
		end
		if tonumber(arg) <= 27 and tonumber(arg) >= 27 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС по дороге к байкерам", 0x6495ED)
		end
		if tonumber(arg) <= 28 and tonumber(arg) >= 28 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС у Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 29 and tonumber(arg) >= 29 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Автобазар", 0x6495ED)
		end
		if tonumber(arg) <= 30 and tonumber(arg) >= 30 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС РКШД", 0x6495ED)
		end
		if tonumber(arg) <= 31 and tonumber(arg) >= 31 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Санта Мария", 0x6495ED)
		end
		if tonumber(arg) <= 32 and tonumber(arg) >= 32 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС у Аксиомы", 0x6495ED)
		end
		if tonumber(arg) <= 33 and tonumber(arg) >= 33 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная ВайнВуд", 0x6495ED)
		end
		if tonumber(arg) <= 34 and tonumber(arg) >= 34 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Санта Мария", 0x6495ED)
		end
		if tonumber(arg) <= 35 and tonumber(arg) >= 35 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Монтгомери", 0x6495ED)
		end
		if tonumber(arg) <= 36 and tonumber(arg) >= 36 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Центр ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 37 and tonumber(arg) >= 37 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Пиццерия в гетто", 0x6495ED)
		end
		if tonumber(arg) <= 38 and tonumber(arg) >= 38 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная за ЦБ", 0x6495ED)
		end
		if tonumber(arg) <= 39 and tonumber(arg) >= 39 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта под ВайнВудом", 0x6495ED)
		end
		if tonumber(arg) <= 40 and tonumber(arg) >= 40 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта у Аксиомы", 0x6495ED)
		end
		if tonumber(arg) <= 41 and tonumber(arg) >= 41 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта в Гетто", 0x6495ED)
		end
		if tonumber(arg) <= 42 and tonumber(arg) >= 42 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Мавериков", 0x6495ED)
		end
		if tonumber(arg) <= 43 and tonumber(arg) >= 43 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 ПК", 0x6495ED)
		end
		if tonumber(arg) <= 44 and tonumber(arg) >= 44 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 у Аксиомы", 0x6495ED)
		end
		if tonumber(arg) <= 45 and tonumber(arg) >= 45 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Ацтеки", 0x6495ED)
		end
		if tonumber(arg) <= 46 and tonumber(arg) >= 46 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 у Мерии", 0x6495ED)
		end
		if tonumber(arg) <= 47 and tonumber(arg) >= 47 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Санта Мария", 0x6495ED)
		end
		if tonumber(arg) <= 48 and tonumber(arg) >= 48 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 у Баллас", 0x6495ED)
		end
		if tonumber(arg) <= 49 and tonumber(arg) >= 49 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная гетто возле грузчиков", 0x6495ED)
		end
		if tonumber(arg) <= 50 and tonumber(arg) >= 50 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная ЦР", 0x6495ED)
		end
		if tonumber(arg) <= 51 and tonumber(arg) >= 51 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар Санта Мария", 0x6495ED)
		end
		if tonumber(arg) <= 52 and tonumber(arg) >= 52 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда семейных лодок", 0x6495ED)
		end
		if tonumber(arg) <= 53 and tonumber(arg) >= 53 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Яхт", 0x6495ED)
		end
		if tonumber(arg) <= 54 and tonumber(arg) >= 54 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Буллетов", 0x6495ED)
		end
		if tonumber(arg) <= 55 and tonumber(arg) >= 55 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Султанов", 0x6495ED)
		end
		if tonumber(arg) <= 56 and tonumber(arg) >= 56  then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта у Больницы ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 57 and tonumber(arg) >= 57 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта ЛВПД", 0x6495ED)
		end
		if tonumber(arg) <= 58 and tonumber(arg) >= 58 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта Форт Карсон", 0x6495ED)
		end
		if tonumber(arg) <= 59 and tonumber(arg) >= 59 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС ЛВПД", 0x6495ED)
		end
		if tonumber(arg) <= 60 and tonumber(arg) >= 60 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС у Больницы ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 61 and tonumber(arg) >= 61 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС за РМ", 0x6495ED)
		end
		if tonumber(arg) <= 62 and tonumber(arg) >= 62 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС ЛКН", 0x6495ED)
		end
		if tonumber(arg) <= 63 and tonumber(arg) >= 63 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Эль Куебрадос", 0x6495ED)
		end
		if tonumber(arg) <= 64 and tonumber(arg) >= 64 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС Тиерра", 0x6495ED)
		end
		if tonumber(arg) <= 65 and tonumber(arg) >= 65 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО Старые Яки", 0x6495ED)
		end
		if tonumber(arg) <= 66 and tonumber(arg) >= 66 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО в Центре ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 67 and tonumber(arg) >= 67 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО Форт Карсон", 0x6495ED)
		end
		if tonumber(arg) <= 68 and tonumber(arg) >= 68 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО Эль Куебрадос", 0x6495ED)
		end
		if tonumber(arg) <= 69 and tonumber(arg) >= 69 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 ЖДЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 70 and tonumber(arg) >= 70 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 СМИ ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 71 and tonumber(arg) >= 71 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Казино", 0x6495ED)
		end
		if tonumber(arg) <= 72 and tonumber(arg) >= 72 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 ЛВПД", 0x6495ED)
		end
		if tonumber(arg) <= 73 and tonumber(arg) >= 73 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 у Больницы ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 74 and tonumber(arg) >= 74 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 ЛКН", 0x6495ED)
		end
		if tonumber(arg) <= 75 and tonumber(arg) >= 75 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Старые Яки", 0x6495ED)
		end
		if tonumber(arg) <= 76 and tonumber(arg) >= 76 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Форт Карсон", 0x6495ED)
		end
		if tonumber(arg) <= 77 and tonumber(arg) >= 77 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 у Заброшенного Аэропорта", 0x6495ED)
		end
		if tonumber(arg) <= 78 and tonumber(arg) >= 78 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Форт Карсон", 0x6495ED)
		end
		if tonumber(arg) <= 79 and tonumber(arg) >= 79 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная ЖДЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 80 and tonumber(arg) >= 80 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Старые Яки", 0x6495ED)
		end
		if tonumber(arg) <= 81 and tonumber(arg) >= 81 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Центр ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 82 and tonumber(arg) >= 82 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная ЛВПД", 0x6495ED)
		end
		if tonumber(arg) <= 83 and tonumber(arg) >= 83 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная у СТО ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 84 and tonumber(arg) >= 84 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Лас Баранкас", 0x6495ED)
		end
		if tonumber(arg) <= 85 and tonumber(arg) >= 85 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Тиерра Робада", 0x6495ED)
		end
		if tonumber(arg) <= 86 and tonumber(arg) >= 86 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар НЛО", 0x6495ED)
		end
		if tonumber(arg) <= 87 and tonumber(arg) >= 87 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар Форт Карсон", 0x6495ED)
		end
		if tonumber(arg) <= 88 and tonumber(arg) >= 88 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар у Заброшенного Аэропорта", 0x6495ED)
		end
		if tonumber(arg) <= 89 and tonumber(arg) >= 89 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО у ЛВПД", 0x6495ED)
		end
		if tonumber(arg) <= 90 and tonumber(arg) >= 90 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО ЖДЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 91 and tonumber(arg) >= 91 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар напротив Казино", 0x6495ED)
		end
		if tonumber(arg) <= 92 and tonumber(arg) >= 92 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар напротив Аренды Буллетов", 0x6495ED)
		end
		if tonumber(arg) <= 93 and tonumber(arg) >= 93 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар у Старых Якудз", 0x6495ED)
		end
		if tonumber(arg) <= 94 and tonumber(arg) >= 94 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар Пираты", 0x6495ED)
		end
		if tonumber(arg) <= 95 and tonumber(arg) >= 95 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аксессуары у ЖДЛС", 0x6495ED)
		end
		if tonumber(arg) <= 96 and tonumber(arg) >= 96 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аксессуары у Баллас", 0x6495ED)
		end
		if tonumber(arg) <= 97 and tonumber(arg) >= 97 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аксессуары у Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 98 and tonumber(arg) >= 98 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аксессуары у Казино", 0x6495ED)
		end
		if tonumber(arg) <= 99 and tonumber(arg) >= 99 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аксессуары у ЖДСФ", 0x6495ED)
		end
		if tonumber(arg) <= 100 and tonumber(arg) >= 100 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аксессуары Автошкола", 0x6495ED)
		end
		if tonumber(arg) <= 101 and tonumber(arg) >= 101 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Автобазар", 0x6495ED)
		end
		if tonumber(arg) <= 102 and tonumber(arg) >= 102 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 СФПД", 0x6495ED)
		end
		if tonumber(arg) <= 103 and tonumber(arg) >= 103 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 на Пирсе СФ", 0x6495ED)
		end
		if tonumber(arg) <= 104 and tonumber(arg) >= 104 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 СМИ СФ", 0x6495ED)
		end
		if tonumber(arg) <= 105 and tonumber(arg) >= 105 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Автосалон СФ", 0x6495ED)
		end
		if tonumber(arg) <= 106 and tonumber(arg) >= 106 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Автобазар", 0x6495ED)
		end
		if tonumber(arg) <= 107 and tonumber(arg) >= 107 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная СМИ СФ", 0x6495ED)
		end
		if tonumber(arg) <= 108 and tonumber(arg) >= 108 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная на Пирсе СФ", 0x6495ED)
		end
		if tonumber(arg) <= 109 and tonumber(arg) >= 109 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Центр СФ", 0x6495ED)
		end
		if tonumber(arg) <= 110 and tonumber(arg) >= 110 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Больница СФ", 0x6495ED)
		end
		if tonumber(arg) <= 111 and tonumber(arg) >= 111 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Пончик у Больницы СФ", 0x6495ED)
		end
		if tonumber(arg) <= 112 and tonumber(arg) >= 112 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Автосалон СФ", 0x6495ED)
		end
		if tonumber(arg) <= 113 and tonumber(arg) >= 113 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная у СФПД", 0x6495ED)
		end
		if tonumber(arg) <= 114 and tonumber(arg) >= 114 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная в Ангел Пайне", 0x6495ED)
		end
		if tonumber(arg) <= 115 and tonumber(arg) >= 115 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО Автосалон СФ", 0x6495ED)
		end
		if tonumber(arg) <= 116 and tonumber(arg) >= 116 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО ЖДСФ", 0x6495ED)
		end
		if tonumber(arg) <= 117 and tonumber(arg) >= 117 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО СМИ СФ", 0x6495ED)
		end
		if tonumber(arg) <= 118 and tonumber(arg) >= 118 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО Ангел Пайн", 0x6495ED)
		end
		if tonumber(arg) <= 119 and tonumber(arg) >= 119 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО у СФПД", 0x6495ED)
		end
		if tonumber(arg) <= 120 and tonumber(arg) >= 120 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО Автосалон СФ", 0x6495ED)
		end
		if tonumber(arg) <= 121 and tonumber(arg) >= 121  then
		  sampAddChatMessage("[Business]: {FFFFFF}МО у ЖДСФ", 0x6495ED)
		end
		if tonumber(arg) <= 122 and tonumber(arg) >= 122 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта у ЖДСФ", 0x6495ED)
		end
		if tonumber(arg) <= 123 and tonumber(arg) >= 123 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта у Автосалона СФ", 0x6495ED)
		end
		if tonumber(arg) <= 124 and tonumber(arg) >= 124 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Транспорта у Больницы СФ", 0x6495ED)
		end
		if tonumber(arg) <= 125 and tonumber(arg) >= 125 then
		  sampAddChatMessage("[Business]: {FFFFFF}Аренда Лимузинов", 0x6495ED)
		end
		if tonumber(arg) <= 126 and tonumber(arg) >= 126 then
		  sampAddChatMessage("[Business]: {FFFFFF}Предприятие Автобазар", 0x6495ED)
		end
		if tonumber(arg) <= 127 and tonumber(arg) >= 127 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО Санта Мария", 0x6495ED)
		end
		if tonumber(arg) <= 128 and tonumber(arg) >= 128 then
		  sampAddChatMessage("[Business]: {FFFFFF}Телефонная Компания ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 129 and tonumber(arg) >= 129 then
		  sampAddChatMessage("[Business]: {FFFFFF}Баннеры ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 130 and tonumber(arg) >= 130 then
		  sampAddChatMessage("[Business]: {FFFFFF}Телефонные Будки ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 131 and tonumber(arg) >= 131 then
		  sampAddChatMessage("[Business]: {FFFFFF}Телефонная Компания ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 132 and tonumber(arg) >= 132 then
		  sampAddChatMessage("[Business]: {FFFFFF}Телефонные Будки СФ", 0x6495ED)
		end
		if tonumber(arg) <= 133 and tonumber(arg) >= 133 then
		  sampAddChatMessage("[Business]: {FFFFFF}Телефонная Компания СФ", 0x6495ED)
		end
		if tonumber(arg) <= 134 and tonumber(arg) >= 134 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 напротив ЦР", 0x6495ED)
		end
		if tonumber(arg) <= 135 and tonumber(arg) >= 135 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная Автошкола", 0x6495ED)
		end
		if tonumber(arg) <= 136 and tonumber(arg) >= 136 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО возле Ночных Волков", 0x6495ED)
		end
		if tonumber(arg) <= 137 and tonumber(arg) >= 137 then
		  sampAddChatMessage("[Business]: {FFFFFF}АЗС СМИ ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 138 and tonumber(arg) >= 138 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Санта Мария (936)", 0x6495ED)
		end
		if tonumber(arg) <= 139 and tonumber(arg) >= 139 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Санта-Мария", 0x6495ED)
		end
		if tonumber(arg) <= 140 and tonumber(arg) >= 140 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель ЦБ", 0x6495ED)
		end
		if tonumber(arg) <= 141 and tonumber(arg) >= 141 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Мерия", 0x6495ED)
		end
		if tonumber(arg) <= 142 and tonumber(arg) >= 142 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Автосалон СФ", 0x6495ED)
		end
		if tonumber(arg) <= 143 and tonumber(arg) >= 143 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Казино", 0x6495ED)
		end
		if tonumber(arg) <= 144 and tonumber(arg) >= 144 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Пирамида", 0x6495ED)
		end
		if tonumber(arg) <= 145 and tonumber(arg) >= 145 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Больница ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 146 and tonumber(arg) >= 146 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Гетто у Аренды Велосипедов", 0x6495ED)
		end
		if tonumber(arg) <= 147 and tonumber(arg) >= 147 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Автошкола", 0x6495ED)
		end
		if tonumber(arg) <= 148 and tonumber(arg) >= 148 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Автобазар", 0x6495ED)
		end
		if tonumber(arg) <= 149 and tonumber(arg) >= 149 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Emerald", 0x6495ED)
		end
		if tonumber(arg) <= 150 and tonumber(arg) >= 150 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель ЛВПД", 0x6495ED)
		end
		if tonumber(arg) <= 151 and tonumber(arg) >= 151 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Rock Hotel", 0x6495ED)
		end
		if tonumber(arg) <= 152 and tonumber(arg) >= 152 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель ЦР", 0x6495ED)
		end
		if tonumber(arg) <= 153 and tonumber(arg) >= 153 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель возле Дерби", 0x6495ED)
		end
		if tonumber(arg) <= 154 and tonumber(arg) >= 154 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Ферма", 0x6495ED)
		end
		if tonumber(arg) <= 155 and tonumber(arg) >= 155 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель ЖДСФ", 0x6495ED)
		end
		if tonumber(arg) <= 156 and tonumber(arg) >= 156 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель Тиерра Робада", 0x6495ED)
		end
		if tonumber(arg) <= 157 and tonumber(arg) >= 157 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель у Рифы 1", 0x6495ED)
		end
		if tonumber(arg) <= 158 and tonumber(arg) >= 158 then
		  sampAddChatMessage("[Business]: {FFFFFF}Отель у Рифы 2", 0x6495ED)
		end
		if tonumber(arg) <= 159 and tonumber(arg) >= 159 then
		  sampAddChatMessage("[Business]: {FFFFFF}СТО ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 160 and tonumber(arg) >= 160 then
		  sampAddChatMessage("[Business]: {FFFFFF}СТО СФ", 0x6495ED)
		end
		if tonumber(arg) <= 161 and tonumber(arg) >= 161 then
		  sampAddChatMessage("[Business]: {FFFFFF}СТО ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 162 and tonumber(arg) >= 162 then
		  sampAddChatMessage("[Business]: {FFFFFF}Error", 0x6495ED)
		end
		if tonumber(arg) <= 163 and tonumber(arg) >= 163 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар у Аэропорта ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 164 and tonumber(arg) >= 164 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар Jizzy", 0x6495ED)
		end
		if tonumber(arg) <= 165 and tonumber(arg) >= 165 then
		  sampAddChatMessage("[Business]: {FFFFFF}Бар Пластинка", 0x6495ED)
		end
		if tonumber(arg) <= 166 and tonumber(arg) >= 166 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная у Ночных Волков", 0x6495ED)
		end
		if tonumber(arg) <= 167 and tonumber(arg) >= 167 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная у Ацтеков", 0x6495ED)
		end
		if tonumber(arg) <= 168 and tonumber(arg) >= 168 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная у Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 169 and tonumber(arg) >= 169 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная в ПК", 0x6495ED)
		end
		if tonumber(arg) <= 170 and tonumber(arg) >= 170 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная у Автосалона ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 171 and tonumber(arg) >= 171 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная у ЛКН", 0x6495ED)
		end
		if tonumber(arg) <= 172 and tonumber(arg) >= 172 then
		  sampAddChatMessage("[Business]: {FFFFFF}Закусочная за ЛВПД", 0x6495ED)
		end
		if tonumber(arg) <= 173 and tonumber(arg) >= 173 then
		  sampAddChatMessage("[Business]: {FFFFFF}МО под ВайнВудом", 0x6495ED)
		end
		if tonumber(arg) <= 174 and tonumber(arg) >= 174 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 Ночные Волки", 0x6495ED)
		end
		if tonumber(arg) <= 175 and tonumber(arg) >= 175 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 под ВайнВудом", 0x6495ED)
		end
		if tonumber(arg) <= 176 and tonumber(arg) >= 176 then
		  sampAddChatMessage("[Business]: {FFFFFF}24/7 у Автошколы", 0x6495ED)
		end
		if tonumber(arg) <= 177 and tonumber(arg) >= 177 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО у Ацтеков", 0x6495ED)
		end
		if tonumber(arg) <= 178 and tonumber(arg) >= 178 then
		  sampAddChatMessage("[Business]: {FFFFFF}АММО у Казино", 0x6495ED)
		end
		if tonumber(arg) <= 179 and tonumber(arg) >= 179 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Налоговой Службы", 0x6495ED)
		end
		if tonumber(arg) <= 180 and tonumber(arg) >= 180 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк Форт Карсон", 0x6495ED)
		end
		if tonumber(arg) <= 181 and tonumber(arg) >= 181 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Казино", 0x6495ED)
		end
		if tonumber(arg) <= 182 and tonumber(arg) >= 182 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Военкомата ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 183 and tonumber(arg) >= 183 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Больницы ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 184 and tonumber(arg) >= 184 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЛВПД 2", 0x6495ED)
		end
		if tonumber(arg) <= 185 and tonumber(arg) >= 185 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк СМИ ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 186 and tonumber(arg) >= 186 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк на пляжу Таможни", 0x6495ED)
		end
		if tonumber(arg) <= 187 and tonumber(arg) >= 187 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Маяка", 0x6495ED)
		end
		if tonumber(arg) <= 188 and tonumber(arg) >= 188 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 189 and tonumber(arg) >= 189 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЖДСФ 2", 0x6495ED)
		end
		if tonumber(arg) <= 190 and tonumber(arg) >= 190 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк ЦР 1", 0x6495ED)
		end
		if tonumber(arg) <= 191 and tonumber(arg) >= 191 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк ЦР 2", 0x6495ED)
		end
		if tonumber(arg) <= 192 and tonumber(arg) >= 192 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк ЦР 3", 0x6495ED)
		end
		if tonumber(arg) <= 193 and tonumber(arg) >= 193 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Ацтеков", 0x6495ED)
		end
		if tonumber(arg) <= 194 and tonumber(arg) >= 194 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЖК Ультра", 0x6495ED)
		end
		if tonumber(arg) <= 195 and tonumber(arg) >= 195 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЖДСФ", 0x6495ED)
		end
		if tonumber(arg) <= 196 and tonumber(arg) >= 196 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк Больница СФ", 0x6495ED)
		end
		if tonumber(arg) <= 197 and tonumber(arg) >= 197 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк У Якудз", 0x6495ED)
		end
		if tonumber(arg) <= 198 and tonumber(arg) >= 198 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк напротив въезда в Аэропорт СФ", 0x6495ED)
		end
		if tonumber(arg) <= 199 and tonumber(arg) >= 199 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЖДЛС", 0x6495ED)
		end
		if tonumber(arg) <= 200 and tonumber(arg) >= 200 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЖДСФ 1", 0x6495ED)
		end
		if tonumber(arg) <= 201 and tonumber(arg) >= 201 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Завода", 0x6495ED)
		end
		if tonumber(arg) <= 202 and tonumber(arg) >= 202 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк Больница ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 203 and tonumber(arg) >= 203 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЦБ", 0x6495ED)
		end
		if tonumber(arg) <= 204 and tonumber(arg) >= 204 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Мерии", 0x6495ED)
		end
		if tonumber(arg) <= 205 and tonumber(arg) >= 205 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Спавна Чёрных", 0x6495ED)
		end
		if tonumber(arg) <= 206 and tonumber(arg) >= 206 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк слева от ЦБ", 0x6495ED)
		end
		if tonumber(arg) <= 207 and tonumber(arg) >= 207 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Отеля Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 208 and tonumber(arg) >= 208 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у СТО возле Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 209 and tonumber(arg) >= 209 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Грузчиков", 0x6495ED)
		end
		if tonumber(arg) <= 210 and tonumber(arg) >= 210 then
		sampAddChatMessage("[Business]: {FFFFFF}Ферма", 0x6495ED)
		end
		if tonumber(arg) <= 211 and tonumber(arg) >= 211 then
		sampAddChatMessage("[Business]: {FFFFFF}Шахта", 0x6495ED)
		end
		if tonumber(arg) <= 212 and tonumber(arg) >= 212 then
		sampAddChatMessage("[Business]: {FFFFFF}Информационный Центр", 0x6495ED)
		end
		if tonumber(arg) <= 213 and tonumber(arg) >= 213 then
		sampAddChatMessage("[Business]: {FFFFFF}СТО у Фермы", 0x6495ED)
		end
		if tonumber(arg) <= 214 and tonumber(arg) >= 214 then
		sampAddChatMessage("[Business]: {FFFFFF}Концертный Зал", 0x6495ED)
		end
		if tonumber(arg) <= 215 and tonumber(arg) >= 215 then
		sampAddChatMessage("[Business]: {FFFFFF}Аренда Велосипедов", 0x6495ED)
		end
		if tonumber(arg) <= 216 and tonumber(arg) >= 216 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЛВПД 1", 0x6495ED)
		end
		if tonumber(arg) <= 217 and tonumber(arg) >= 217 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у Старых Якудз", 0x6495ED)
		end
		if tonumber(arg) <= 218 and tonumber(arg) >= 218 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЛСПД", 0x6495ED)
		end
		if tonumber(arg) <= 219 and tonumber(arg) >= 219 then
		sampAddChatMessage("[Business]: {FFFFFF}Ларёк у ЖДЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 220 and tonumber(arg) >= 220 then
		sampAddChatMessage("[Business]: {FFFFFF}Автосалон ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 221 and tonumber(arg) >= 221 then
		sampAddChatMessage("[Business]: {FFFFFF}Автосалон ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 222 and tonumber(arg) >= 222 then
		sampAddChatMessage("[Business]: {FFFFFF}Автосалон СФ", 0x6495ED)
		end
		if tonumber(arg) <= 223 and tonumber(arg) >= 223 then
		sampAddChatMessage("[Business]: {FFFFFF}Салон Тюнинга ЛС", 0x6495ED)
		end
		if tonumber(arg) <= 224 and tonumber(arg) >= 224 then
		sampAddChatMessage("[Business]: {FFFFFF}Салон Тюнинга СФ", 0x6495ED)
		end
		if tonumber(arg) <= 225 and tonumber(arg) >= 225 then
		sampAddChatMessage("[Business]: {FFFFFF}Салон Тюнинга ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 226 and tonumber(arg) >= 226 then
		sampAddChatMessage("[Business]: {FFFFFF}Спорт Зал ЛВ", 0x6495ED)
		end
		if tonumber(arg) <= 227 and tonumber(arg) >= 227 then
		sampAddChatMessage("[Business]: {FFFFFF}Контейнеры", 0x6495ED)
		end
		if tonumber(arg) <= 228 and tonumber(arg) >= 228 then
		sampAddChatMessage("[Business]: {FFFFFF}СТО Форт Карсон", 0x6495ED)
		end
		if tonumber(arg) <= 229 and tonumber(arg) >= 229 then
		sampAddChatMessage("[Business]: {FFFFFF}Казино", 0x6495ED)
		end
		if tonumber(arg) <= 230 and tonumber(arg) >= 230 then
		sampAddChatMessage("[Business]: {FFFFFF}Центральный Рынок", 0x6495ED)
		end
		if tonumber(arg) <= 231 and tonumber(arg) >= 231 then
		sampAddChatMessage("[Business]: {FFFFFF}Магазин 24/7 ЦР", 0x6495ED)
		end
		if tonumber(arg) <= 232 and tonumber(arg) >= 232 then
		sampAddChatMessage("[Business]: {FFFFFF}Магазин Аксессуаров ЦР", 0x6495ED)
		end
		if tonumber(arg) <= 233 and tonumber(arg) >= 233 then
		sampAddChatMessage("[Business]: {FFFFFF}Магазин Одежды ЦР", 0x6495ED)
		end
		if tonumber(arg) == 234 then
		sampAddChatMessage("[Business]: {FFFFFF}Школа танцев ЛС", 0x6495ED)
		end
		if tonumber(arg) == 235 then
		sampAddChatMessage("[Business]: {FFFFFF}Школа танцев СФ", 0x6495ED)
		end
		if tonumber(arg) == 236 then
		sampAddChatMessage("[Business]: {FFFFFF}Школа танцев ЛВ", 0x6495ED)
		end
		if tonumber(arg) == 237 then
		sampAddChatMessage("[Business]: {FFFFFF}Мастерская одежды ФК", 0x6495ED)
		end
		if tonumber(arg) == 238 then
		sampAddChatMessage("[Business]: {FFFFFF}Мастерская одежды ПК", 0x6495ED)
		end
		if tonumber(arg) == 239 then
		sampAddChatMessage("[Business]: {FFFFFF}Мастерская одежды РКПД", 0x6495ED)
		end
		if tonumber(arg) == 240 then
		sampAddChatMessage("[Business]: {FFFFFF}Мастерская одежды Эль Куебрадос", 0x6495ED)
		end
		if tonumber(arg) == 241 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у ЛКН (ближняя)", 0x6495ED)
		end
		if tonumber(arg) == 242 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у ПК", 0x6495ED)
		end
		if tonumber(arg) == 243 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у ГТ", 0x6495ED)
		end
		if tonumber(arg) == 244 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у замка СФ", 0x6495ED)
		end
		if tonumber(arg) == 245 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у Чиллиада", 0x6495ED)
		end
		if tonumber(arg) == 246 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у гетто", 0x6495ED)
		end
		if tonumber(arg) == 247 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у ЛКН (дальняя)", 0x6495ED)
		end
		if tonumber(arg) == 248 then
		sampAddChatMessage("[Business]: {FFFFFF}Нефтевышка у леса Чиллиада", 0x6495ED)
		end
		if tonumber(arg) == 249 then
		sampAddChatMessage("[Business]: {FFFFFF}Лодочная АЗС Санта Мария", 0x6495ED)
		end
		if tonumber(arg) == 250 then
		sampAddChatMessage("[Business]: {FFFFFF}Лодочная АЗС пирс ЛВ", 0x6495ED)
		end
		if tonumber(arg) == 251 then
		sampAddChatMessage("[Business]: {FFFFFF}Лодочная АЗС у лесопилки", 0x6495ED)
		end
		if tonumber(arg) == 252 then
		sampAddChatMessage("[Business]: {FFFFFF}Лодочная АЗС в СФ", 0x6495ED)
		end
		if tonumber(arg) == 253 then
		sampAddChatMessage("[Business]: {FFFFFF}Лодочная АЗС в Блюберри", 0x6495ED)
		end
		if tonumber(arg) < 0 then
		sampAddChatMessage("[Business]: {FFFFFF}Use /fb 0-253", 0x6495ED)
		end
		if tonumber(arg) >= 254 then
		sampAddChatMessage("[Business]: {FFFFFF}Use /fb 0-253", 0x6495ED)
		end
	end
end
