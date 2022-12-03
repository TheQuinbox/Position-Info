local ax = require "hs.axuielement"
local inspect = hs.inspect

local PositionInfo = {}
PositionInfo.name = "Position Information"
PositionInfo.version = "1.0"
PositionInfo.author = "Quin Marilyn <quin.marilyn05@gmail.com>"
PositionInfo.license = "MIT"
PositionInfo.homepage = "https://www.github.com/TheQuinbox/Position-Info"

local synth = hs.speech.new()

local function speak(text)
	if hs.application.get("VoiceOver") ~= nil then
		hs.osascript.applescript("tell application \"VoiceOver\" to output \"" .. text .. "\"")
	else 
		synth:speak(text)
	end 
end

function round(numToRound, numDecimalPlaces)
	if numDecimalPlaces and numDecimalPlaces > 0 then
		local mult = 10 ^ numDecimalPlaces
		return math.floor(numToRound * mult + 0.5) / mult
	end
	return math.floor(numToRound + 0.5)
end

local function percent(n1, n2)
	return round((n1 / n2) * 100)
end

local function checkPositionInfo()
	local systemElement = ax.systemWideElement()
	local element = systemElement.AXFocusedUIElement
	if element == nil then
		return
	end
	local role = element.AXRole
	if role == "AXTable" or role == "AXOutline" then
		local current = element.AXSelectedRows[1].AXIndex
		local total = #element.AXRows
		speak(percent(current, total) .. "% (item " .. current .. " of " .. total .. ").")
	elseif role == "AXTextArea" or role == "AXTextField" then
		local caret = element.AXSelectedTextRange["location"]
		local total = element.AXNumberOfCharacters
		local percentage = percent(caret, total)
		-- If a text field is empty, we get nan for the percentage, so convert it to 0.
		-- This works because a nan value is equal to nothing (including itself).
		if percentage ~= percentage then
			percentage = 0
		end
		speak(percentage .. " percent (Character " .. caret .. " of " .. total)
	end
end

local checkHotkey = hs.hotkey.new("ctrl-shift", "p", checkPositionInfo)

function PositionInfo.init()
end

function PositionInfo.start()
	checkHotkey:enable()
end

function PositionInfo.stop()
	checkHotkey:disable()
end

return PositionInfo
