function onClientScriptData(player) {
	local type = Stream.ReadInt();
	switch(type) {
		case 0:
		Message("[#ffffff]" + player.Name + " have his client loaded!");
		break;
	}
}