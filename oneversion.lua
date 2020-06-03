require "lib.moonloader" -- подключение библиотеки
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local dlstatus = require("moonloader").download_status
local inicfg = require "inicfg"
local directIni = "moonloader\\oneversion.ini"
local mainIni = inicfg.load(nil, directIni)
local stateIni = inicfg.save(mainIni, directIni)
update_state = false
local script_vers = 2
local script_vers_text = "1.05"
local update_url = "https://raw.githubusercontent.com/ReyesFam/oneversion/master/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"
local script_url = "https://raw.githubusercontent.com/ReyesFam/oneversion/3584b5855c36cbe4eaa20bc08b704d74c12b7bf3/oneversion.lua"
local script_path = thisScript().path
local tag = "OneVersion"

local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local sw, sh = getScreenResolution()
local house = imgui.ImBuffer(mainIni.config.house, 500)
local biz = imgui.ImBuffer(mainIni.config.biz, 500)
local test = imgui.ImBuffer(256)
local test2 = imgui.ImBuffer(256)

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand("imgui", cmd_imgui)
	sampRegisterChatCommand(tostring(mainIni.config.house), cmd_h)
	sampRegisterChatCommand(tostring(mainIni.config.biz), cmd_b)
	sampRegisterChatCommand("getinfo", cmd_getinfo)
	sampRegisterChatCommand("setinfo", cmd_setinfo)

	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage("Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
				update_state = true
			end
			os.remove(update_path)
		end
	end)

  imgui.Process = false

	sampAddChatMessage(tag .. " {00FF7F}| {ffffff}Загрузка завершена",0xFF1493)

	-- Блок выполняется один раз после старта сампа

	while true do
		wait(0)

		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("Скрипт обновлён", -1)
					thisScript():reload()
				end
			end)
			break
		end

		if main_window_state.v == false then
      imgui.Process = false
    end
		-- блок выполняется бесконечно (пока самп активен)
	end
end

function cmd_imgui(arg)
  main_window_state.v = not main_window_state.v
  imgui.Process = main_window_state.v
end

function imgui.OnDrawFrame()
    imgui.SetNextWindowSize(imgui.ImVec2(500, 300), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin("Reyes Helper", main_window_state)
    if imgui.CollapsingHeader(u8"Сокращённые команды") then
			imgui.Text(u8"Ваша команда")
			imgui.PushItemWidth(100)
			imgui.InputText("/findihouse", house, imgui.SameLine())
			imgui.PopItemWidth()
			imgui.Text(u8"Ваша команда")
			imgui.PushItemWidth(100)
			imgui.InputText("/findibiz", biz, imgui.SameLine())
			imgui.PopItemWidth()
			if imgui.Button(u8'Сохранить настройки') then
			mainIni.config.house = house.v
			mainIni.config.biz = biz.v
			inicfg.save(mainIni, directIni)
			sampAddChatMessage("Выполнено", -1)
		end
	 end
	 if imgui.CollapsingHeader(u8"О скрипте") then
		 imgui.Text(u8"Создатель скрипта")
		 imgui.Text("Leonardo_Reyes")
	  end
		if imgui.CollapsingHeader(u8"Обновление") then
			imgui.Text(u8"Загружена последняя версия обновления")
		 end
		imgui.SetCursorPosX(25)
    imgui.SetCursorPosY(260)
		if imgui.Button(u8"Перезагрузить скрипт") then
			thisScript():reload()
	  end
    imgui.SetCursorPosX(375)
    imgui.SetCursorPosY(280)
    imgui.Text("By Leonardo_Reyes")
    imgui.End()
end

function cmd_h(arg)
	sampSendChat("/findihouse " .. arg)
	arg = arg + 0
	if arg <= 0 and arg >= 0 then
		sampAddChatMessage("{8A2BE2}[Forum House]: {FFFFFF}Maze Bank", 0xFFFFFF)
	end
	if arg <= 1 and arg >= 1 then
		sampAddChatMessage("{8A2BE2}[House]: {FFFFFF}ЛКН", 0xFFFFFF)
	end
end

function cmd_b(arg)
	sampSendChat("/findibiz " .. arg)
	arg = arg + 0
	if arg <= 0 and arg >= 0 then
		sampAddChatMessage("[Business]: {FFFFFF}АММО ЛС", 0x6495ED)
	end
	if arg <= 1 and arg >= 1 then
		sampAddChatMessage("[Business]: {FFFFFF}АММО ПК", 0x6495ED)
	end
	if arg <= 2 and arg >= 2 then
		sampAddChatMessage("[Business]: {FFFFFF}АММО у Фермы", 0x6495ED)
	end
end
