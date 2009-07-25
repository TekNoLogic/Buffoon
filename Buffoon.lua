
local colors = {}
for class,color in pairs(RAID_CLASS_COLORS) do colors[class] = string.format("|cff%02x%02x%02x", color.r*255, color.g*255, color.b*255) end


local function ColoredName(unit)
	local _ ,class = UnitClass(unit)
	return colors[class]..UnitName(unit)
end


local obj = LibStub("LibDataBroker-1.1"):NewDataObject("Buffoon", {type = "data source", text = "Who?"})


------------------------
--      Tooltip!      --
------------------------

local function GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end


function obj.OnLeave() GameTooltip:Hide() end
function obj:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(GetTipAnchor(self))
	GameTooltip:ClearLines()

	GameTooltip:AddLine("WhoBufft?")
	GameTooltip:AddDoubleLine("Spell", "Caster")
	for i=1,40 do
		local name, rank, texture, _, bufftype, _, _, unit, _ = UnitBuff("player", i)
		if name and unit and unit ~= "player" then GameTooltip:AddDoubleLine("|T"..texture..":20|t "..name, ColoredName(unit), 1,1,1) end
	end

	GameTooltip:Show()
end
