--- 
local ItemRack = ItemRack
assert(ItemRack, "ItemRack required")

local Masque = LibStub("Masque")
assert(Masque, "Masque required")

local Addon = CreateFrame("Frame")
Addon:SetScript("OnEvent", 
	function(Frame, Event, ...)
		Frame[Event](Frame, ...)
	end
)

local Constants = {
	ItemRack = "ItemRack",
	Groups = {
		"Set Buttons",
		"Menu Buttons"
	}
}

local _G = _G

function Addon:PLAYER_ENTERING_WORLD()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")

    for _, Group in pairs(Constants.Groups) do
    	Masque:Group(Constants.ItemRack, Group)
	end

	for Idx = 0, 20 do
		local Button = _G["ItemRackButton" .. Idx]
		if Button ~= nil then
			Masque:Group(Constants.ItemRack, Constants.Groups[1]):AddButton(Button)
		end
	end

	if ItemRack.CreateMenuButton then
		hooksecurefunc(ItemRack,"CreateMenuButton", 
			function(Idx, ItemId, ...) 
				if Idx == nil then
					return
				end

				local Button = _G["ItemRackMenu" .. Idx]
				if Button ~= nil then
					Masque:Group(Constants.ItemRack, Constants.Groups[2]):AddButton(Button)
				end
			end
		)
	end
end

Addon:RegisterEvent("PLAYER_ENTERING_WORLD")