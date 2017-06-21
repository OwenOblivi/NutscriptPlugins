local PLUGIN = PLUGIN
PLUGIN.name = "Message Of The Day"
PLUGIN.author = "OwenOblivi"
PLUGIN.desc = "Allows you to set a message of the day, similar to ULX."

nut.config.add("MOTDURL", "http://nutscript.rocks/", "The URL for the Message of the Day.", nil, {
	category = "MOTD"
})

nut.config.add("toggleMOTD", true, "Toggle the MOTD on or off.", nil, {
	category = "MOTD"
})

function motd()
	local frame = vgui.Create( "DFrame" );
		frame:SetTitle( "MOTD" );
		frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 );
		frame:Center();frame:MakePopup();

	local html = vgui.Create( "HTML", frame );
		html:Dock( FILL );
		html:OpenURL(nut.config.get("MOTDURL"));
end

local function MOTDcommand( pl, text, teamonly )
	if nut.config.get("toggleMOTD") == true then
			if (string.lower(text) == "!motd") then
				pl:SendLua([[motd()]])
			end
	else
		return
	end
end
hook.Add( "PlayerSay", "MOTDopener", MOTDcommand )

hook.Add( "PlayerLoadedChar", "MOTDspawn", function(ply)
		if nut.config.get("toggleMOTD") == true then
			ply:SendLua([[motd()]])
		else
			return
		end
	end)
